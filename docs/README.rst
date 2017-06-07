===============================================================================
Lab 1.1 - Provision an AWS/F5 lab environment in an isolated VPC with Terraform
===============================================================================

Prerequisites:
--------------
- Install git
- Install terraform
- Install AWS CLI
- Generate 2 x BigIP Evaluation keys for: F5-BIG-VE-BT-25M-V13-LIC
- Create AWS User and generate Access key ID and Secrete Access key. (Explained below)

Task 1 - Create AWS User and generate Access key Id and Secrete Access key.
---------------------------------------------------------------------------

1. From the AWS Console -> Services -> Security, Identity & Compliance ->  IAM -> Users -> "Add user"
2. Check to enable Access type* : Programmatic access
3. Attach existing policies directly : AdministratorAccess.

.. note:: You almost certainly don't need AdministratorAccess. We'll lock down permissions in a future revision once I work out the minimum.

4. "Next: Review"
5. "Create user"
6. Copy and save the Access key Id and Secret access key to a text file for later use.

Task 2 - Accept license agreement.
----------------------------------
1. If you haven't done so already, in the AWS Marketplace, find the BYOL F5 ami we're going to run (ami-4c76185a). Attempt to manually provision via the Marketplace only to the point where you click to accept the license agreement, then stop! Cloudformation deployments of F5 will fail if you don't accept the agreement.

Task 3 - Configure the AWS console with Access key ID, Secret access key and generate ssh keys.
-----------------------------------------------------------------------------------------------
Drop into a bash shell / terminal for all of Task 3.

1. Configure aws cli access. Cut and paste the aws keys when prompted and chose your preferred region [i.e. us-east-1].

.. code-block:: bash

   aws configure

2. Create ssh key pairs. Public key will be stored in AWS as "MyKeyPair". Both your public and private key will be exported to MyKeyPair.pm in your working directory. This is what we'll later use to ssh to all of our AWS instances.

.. code-block:: bash

   aws ec2 create-key-pair --key-name MyKeyPair --query 'KeyMaterial' --output text | out-file -encoding ascii -filepath MyKeyPair.pem

Clone this project's git repository and change to working directory.

.. code-block:: bash

   git clone https://github.com/TonyMarfil/marfil-f5-terraform
   cd ./marfil-f5-terraform/

Task 4 - Create entire AWS/F5 environment with a single command: terraform apply
--------------------------------------------------------------------------------
Drop into a bash shell / terminal for all of Task 4.

1. Check terraform version is the tested v0.9.6:

.. code-block:: bash

   terraform --version
   terraform v0.9.6

2. Export the AWS keys and BigIP license variables with the AWS keys and BigIP licenses you created earlier.

.. code-block:: bash

   export AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXX
   export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   export TF_VAR_licenseKey1=XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
   export TF_VAR_licenseKey2=XXXXX-XXXXX-XXXXX-XXXXX-XXXXX

3. Invoke 'terraform apply'

.. code-block:: bash

   terraform plan
   terraform apply

Go make yourself an espresso and come back in 10 minutes...

When done you should see a message like the one below.

.. code-block:: bash
   
   Outputs:

   bigipExternalSecurityGroup = sg-xxxxxxxx
   bigipManagementSecurityGroup = sg-xxxxxxxx
   elb_dns_name = terraform-asg-example-xxxxxxxxx.us-east-1.elb.amazonaws.com
   licenseKey1 = XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
   licenseKey2 = XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
   managementSubnetAz1 = subnet-xxxxxxxx
   managementSubnetAz2 = subnet-xxxxxxxx
   restrictedSrcAddress = 0.0.0.0/0
   sshKey = MyKeyPair
   vpc-id = vpc-xxxxxxxx
   vpc-private-d = 10.0.100.0/24
   vpc-private-d-id = subnet-xxxxxxxx
   vpc-private-e = 10.0.100.0/24
   vpc-private-e-id = subnet-xxxxxxxx
   vpc-public-d = 10.0.1.0/24
   vpc-public-d-id = subnet-xxxxxxxx
   vpc-public-e = 10.0.1.0/24
   vpc-public-e-id = subnet-xxxxxxxx

Terraform has successfully done it's job, but we still have to wait for instances to spin up. Log back in to the AWS Console to track status of the new instances.

4. Two environments were created within a new VPC. The first environment is an ELB load-balancing two instances in an Auto Scaling group across two availability zones. You can test with the elb_dns_name in the terraform output.

.. code-block:: bash

   terraform output | grep elb_dns_name
   elb_dns_name = terraform-asg-example-xxxxxxxxx.us-east-1.elb.amazonaws.com
   curl http://terraform-asg-example-xxxxxxxxx.us-east-1.elb.amazonaws.com

The second environment is the "BIG-IP in AWS - Clustered 2-NIC across Availability Zones" up on GitHub with six web server instances across two Availability Zones (three web servers per AZ).

https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/cluster/2nic/across-az-ha

.. note:: "Autoscaling the BIG-IP Web Application Firewall in AWS" is a good fit for a next attempt: https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/solutions/autoscale/waf/

Task 5 - Deploy a virtual server on BigIP Cluster across two Availability Zones
-------------------------------------------------------------------------------

1. AWS Console -> Services -> EC2 -> Running Instances. Note the IPv4 Public IP addresses for the two instances named: "Big-IP: f5-cluster"

2. Highlight the primary Big-IP : f5-cluster. In the Description tab, note the first assigned Elastic IP, this is the public management IP address. Note the Secondary private IP. This is the IP to be assigned to the virtual server we will soon configure.

3. Highlight the second Big-IP : f5-cluster. In the Description tab, note the first assigned Elastic IP, this is the public management IP address. note the Secondary private IP. This is the IP to be assigned to the virtual server we will soon configure.

4. Use the MyKeyPair.pem to ssh to the management IP address of the BigIPs noted in steps 3 and 4 above.

5. Create an admin password so you can login to the WebUI.

.. code-block:: bash

   modify auth user admin shell bash
   modify auth user admin password xxxxxxxx

6. Login to the BigIP WebUI.

7. The "HA_Across_AZs" iApp will already be deployed in the Common partition.

8. Download the latest iApp package from https://downloads.f5.com. I tested with iapps-1.0.0.455.0.zip.

9. Extract \iapps-1.0.0.455.0\TCP\Release_Candidates\f5.tcp.v1.0.0rc2.tmpl. This is the tested version of the iApp.

10. Import f5.tcp.v1.0.0rc2.tmpl to the primary BigIP. The secondary BigIP should pick up the configuration change automatically.

11. Deploy an iApp using the f5.tcp.v1.0.0rc2.tmpl template.

12. Configure iApp:

Traffic Group: UNCHECK "Inherit traffic group from current partition / path"
Name: vs1

High Availability. What IP address do you want to use for the virtual server? **Secondary private IP address of the first BigIP.**

What is the associated service port? **HTTP(80)**

What IP address do you wish to use for the TCP virtual server in the other data center or availability zone? **Secondary private IP address of the second BigIP.**

.. note:: The preconfigured HA_Across_AZs iApp has both of the IP addresses for the virtual servers prepopulated. The virtual server IP address configured here has to match the virtual server IP address configured in the HA_Across_AZs iApp.

Which servers are part of this pool? **Private IP address of web-az1.0-2 and web-az2.0-2.** Port: **8080.**

**Finished!**

13. Login to the other BigIP WebUI and confirm the changes are in sync.

14. Confirm the virtual server is up!

.. code-block:: bash

   curl http://52.205.85.86


   StatusCode        : 200
   StatusDescription : OK
   Content           : Hello, World
   ...


Stop the active BigIP instance and three web-az1.x instances in AZ1 via the AWS console and the elastic IP will 'float' over to the second BigIP.