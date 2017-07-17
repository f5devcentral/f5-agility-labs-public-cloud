Task 0 - Prerequisites
----------------------

.. important:: Decryption password and IP address of the BigIQ License Server will be announced at the start of the lab.

For this lab you will only need a laptop or workstation with: a working installation of docker on any operating system, an Internet connection and a web browser compatible with the aws web console. Any of the aws supported browsers will do:

https://aws.amazon.com/premiumsupport/knowledge-center/browsers-management-console/

1. Install Docker:

   - Mac:
     https://docs.docker.com/docker-for-mac/

   - Windows:
     https://docs.docker.com/docker-for-windows/install/

   - Linux
     https://docs.docker.com/engine/installation/

2. Confirm your source IP address:

   - http://www.ipchicken.com
   - http://www.iplocation.net
   - http://www.whatismyip.com

Task 1 - Prepare the F5-Super-Netops container and create your AWS lab account
-----------------------------------------------------------------------------

1. From a Linux terminal, MacOS terminal, or Windows PowerShell, launch super-netops docker container.

.. code-block:: bash

   docker run -p 8080:80 -p 2222:22 -it f5devcentral/f5-super-netops-container:base

2. Wait until the f5-super-netops container has finished launching. From inside the container:

- Change to your home directory. 
- Clone the git repository for this lab.
- Change to the working directory.
- Run the f5-super-netops-install.sh script.

Cut and paste the commands below to accomplish the steps above.
   
.. code-block:: bash

   cd ~
   git clone https://github.com/TonyMarfil/marfil-f5-terraform
   cd ~/marfil-f5-terraform/
   source ./scripts/f5-super-netops-install.sh

.. attention:: For a smooth ride, always invoke commands as root, from inside the cloned git repository. To check you're in the right place:

.. code-block:: bash
   
   pwd

...output should read "/root/marfil-f5-terraform"


.. attention:: You can run the entire lab successfully from your terminal without having to ssh into the container. However, if you decide to run this lab via an ssh session to a docker container, the super-netops-container created here or one provided for you, then immediately after you ssh into the super-netops-container make sure to run bash as super user / root by invoking the command:

.. code-block:: bash
   
   su -

3. When prompted, enter the decryption password, email address, and aws console password. The email address is used to create an aws console login and to tag all of your lab components.

4. Invoke terraform.

.. attention:: If Big-IQ License Manager has been configured previously, use the provided address. Otherwise cut and paste from below.

.. code-block:: bash

   terraform plan -var bigiqLicenseManager="null"

   terraform apply -var bigiqLicenseManager="null"

When 'terraform apply' completes, note the \*\*aws_alias\*\* and vpc-id values. Open up your \*\*aws_alias\*\* link in a browser and login to the AWS console with the email address and password you created during the install. You can always get these values by invoking terraform output with the variable name:

.. code-block:: bash

   terraform output **aws_alias**
   terraform output vpc-id


.. Note:: "But what if I forgot my password!"
   
   cat ./passwd

Task 2 - Login to the AWS console
---------------------------------

1. Use the alias aws console link, email address and password you created earlier to login to the aws console. Navigate to Services => Networking & Content Delivery => VPC. Click on # VPCs. In the search field type your email address or last three digits of your vpc-id. You should see your VPC details.

2. Services => Compute => EC2 => Resources => # Running Instances. In the search field enter your email address. You should see your newly created instance running.

3. While your instances and ELB are waking up, you can test with the command:

.. code-block:: bash

   while :; do curl `terraform output elb_dns_name`; sleep 1; done

...until you see a reply 'Hello, World'. Hit <ctrl>+C to stop.

Task 3 - License Big-IQ License Manager and apply license pools
---------------------------------------------------------------

.. note::  The students will not have to complete this task. The Big-IQ License Manager need only be created once with enough pool licenses to accommodate the class.

.. important:: This version of the lab will only work on the shared Field Sales Engineers account while we test. For authenticating Big-IP virtual instances to Big-IQ License Manager, the CloudFormation templates rely on a passwd file in an S3 bucket. The buckets are not public and not accessible outside of our shared AWS account. If you want to edit this to work on a different AWS account:

   - Create a passwd text file (no extension) and upload to your own S3 bucket.
   - Edit f5-cloudformation-cross-az-ha-bigiq.tf.dormant. Look for:

.. code-block:: text

   bigiqPasswordS3Arn   =

...and change the arn to reflect the new arn of your passwd file.


1. SSH into the Big-IQ License Manager. Be patient, the Big-IQ License Manager instance is the last one to come up. This might take up to 5 minutes.

ssh -i ./MyKeyPair-[email address].pem admin@`terraform output aws_instance.bigiq.public_ip`

...so if you created an account with t.marfil@f5.io:

ssh -i ./MyKeyPair-t.marfil@f5.io.pem admin@`terraform output aws_instance.bigiq.public_ip`

...autocomplete should be even quicker: ssh -i ./M <Tab> will autocomplete with the correct key name.

2. From Big-IQ tmsh, create an admin password so we can later login to the configuration utility and use the SOAP client to license Big-IQ with F5-BIQ-VE-MAX-LIC license.

.. code-block:: bash

   modify auth user admin password mylabpass
   save sys config
   bash
   /usr/local/bin/SOAPLicenseClient --verbose --basekey XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
   exit
   quit

3. Note the terraform output value for aws_instance.bigiq.public_ip. HTTPS to this IP address from the browser and apply one or more F5-BIG-VEP3-25M-4V13-LIC pool licenses.

.. code-block:: bash

   terraform output aws_instance.bigiq.public_ip

4. When you login to Big-IQ via the configuration utility (web ui), you will have to rename bigiq1 => bigiq1.local to get past the Management Address screen and make sure to configure ntp with pool.ntp.org. Click next past the password screen without making any changes. Aside from the aforementioned,  click next, next, next... and accept all defaults.

5. Navigate to Big-IQ Device Manager => Operations => License Management => Licenses. Click on New License. Apply the F5-BIG-VEP3-25M-4V13-LIC pool license registration key.

   License Name: bigiqLicPool

   Activation Method: Automatic

6. Click Activate.

7. Accept the EULA.

8. Wait for Status: * Active.

Task 4 - Launch CloudFormation Templates!
-----------------------------------------

We are going to launch two cloud formation templates simultaneously.

- Auto scaling the BIG-IP VE Web Application Firewall in AWS:

 https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/solutions/autoscale/waf/

.. image:: ./images/config-diagram-autoscale-waf.png

- ...and the experimental version of "Deploying the BIG-IP in AWS - Clustered 2-NIC across Availability Zones" which supports automatic Big-IQ Licensing:

 https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/cluster/2nic/across-az-ha

.. image:: ./images/aws-2nic-cluster-across-azs.png

1. Let's wake-up the F5 cloud formation templates that have been laying dormant! From the f5-super-netops container shell:

.. code-block:: bash

   mv f5-cloudformation-autoscale-waf.tf.dormant f5-cloudformation-autoscale-waf.tf
   mv f5-cloudformation-cross-az-ha-bigiq.tf.dormant f5-cloudformation-cross-az-ha-bigiq.tf
   terraform plan -var bigiqLicenseManager=`terraform output aws_instance.bigiq.public_ip`
   terraform apply -var bigiqLicenseManager=`terraform output aws_instance.bigiq.public_ip`

2. Track things are going well in the AWS management console: Services => Management Tools => CloudFormation template. When done, both of your deployed CloudFormation templates will be Status: CREATE_COMPLETE. We still have to wait ~20 minutes for our environment to be ready.

3. From the f5-super-netops terminal, When done you should see a message like the one below. 

.. code-block:: bash
   
   Outputs:

   bigipExternalSecurityGroup = sg-xxxxxxxx
   bigipManagementSecurityGroup = sg-xxxxxxxx
   elb_dns_name = terraform-asg-example-xxxxxxxxx.us-east-1.elb.amazonaws.com
   ...
   ...

Terraform has successfully done its job, but we still must wait for instances to spin up. Log back in to the AWS console to track status of the new instances. This can take up to 20 minutes.

20 minutes later...

Task 5 - Verify a healthy F5 environment
----------------------------------------

1. Find the public IP management address of the three BigIP instances that we created. Let's confirm they're up.

.. code-block:: bash

   ssh -i ./MyKeyPair-[email address].pem admin@[public ip address or DNS name of autoscale waf bigip]

2. Verify the auto-scale WAF is up and the virtual server is up. 

.. code-block:: bash

   modify auth user admin password [mylabpass]
   save sys config
   show ltm virtual-address

3. Login to the AWS Console and find the DNS name of the WAF autoscale load balancer. Services => EC2 => Load Balancers. Filter with your email address. Under the Description tab beneath look for the \*DNS name.

4. From the f5-super-netops container test our https service is up:

.. code-block:: bash

   curl -k https://waf-x-x.us-east-1.elb.amazonaws.com where waf-x-x is the dns name you noted in the AWS console.
   Hello, World

.. code-block:: bash

   ssh -i ./MyKeyPair-[email address].pem admin@[public ip address of primary cross-az hav bigip]

.. code-block:: bash

   modify auth user admin password mylabpass
   save sys config

Task 6 - Deploy a virtual server on a BigIP Cluster across two Availability Zones
----------------------------------------------------------------------------------

1. Navigate to AWS Console -> Services -> EC2 -> Running Instances. Note the IPv4 Public IP addresses for the two instances named: "Big-IP: f5-cluster"

2. Highlight the primary Big-IP : f5-cluster. In the Description tab, note the first assigned Elastic IP, this is the public management IP address. Note the Secondary private IP. This is the IP to be assigned to the virtual server we will soon configure.

3. Highlight the second Big-IP : f5-cluster. In the Description tab, note the first assigned Elastic IP, this is the public management IP address. note the Secondary private IP. This is the IP to be assigned to the virtual server we will soon configure.

4. Use MyKeyPair-[email address].pem generated previously to ssh to the management IP address of the BigIPs noted in steps 3 and 4 above.

5. Create an admin password so you can login to the configuration utility (web ui).

.. code-block:: bash

   modify auth user admin password mylabpass
   save sys config

6. Login to the active BigIP configuration utility (web ui).

7. The "HA_Across_AZs" iApp will already be deployed in the Common partition.

8. Download the latest iApp package from https://downloads.f5.com. I tested with iapps-1.0.0.455.0.zip.

9. Extract \iapps-1.0.0.455.0\TCP\Release_Candidates\f5.tcp.v1.0.0rc2.tmpl. This is the tested version of the iApp.

10. Import f5.tcp.v1.0.0rc2.tmpl to the primary BigIP. The secondary BigIP should pick up the configuration change automatically.

11. Deploy an iApp using the f5.tcp.v1.0.0rc2.tmpl template.

12. Configure iApp:

    Traffic Group: UNCHECK "Inherit traffic group from current partition / path"

    Name: **vs1**

    High Availability. What IP address do you want to use for the virtual server? **Secondary private IP address of the first BigIP.**

.. note:: The preconfigured HA_Across_AZs iApp has both IP addresses for the virtual servers prepopulated. The virtual server IP address configured here must match the virtual server IP address configured in the HA_Across_AZs iApp.

   What is the associated service port? **HTTP(80)**

   What IP address do you wish to use for the TCP virtual server in the other data center or availability zone? **Secondary private IP address of the second BigIP.**

.. note:: The preconfigured HA_Across_AZs iApp has both IP addresses for the virtual servers prepopulated. The virtual server IP address configured here must match the virtual server IP address configured in the HA_Across_AZs iApp.

   Which servers are part of this pool? **Private IP address of web-az1.0 and web-az2.0.** Port: **80**

   **Finished!**

13. Login to the standby BigIP configuration utility (web ui) and confirm the changes are in sync.

14. Confirm the virtual server is up!

.. code-block:: bash

   curl http://52.205.85.86


   StatusCode        : 200
   StatusDescription : OK
   Content           : Hello, World
   ...


Stop the active BigIP instance in AZ1 via the AWS console and the elastic IP will 'float' over to the second BigIP.

Task 7 - Application Services iApp, Service Discovery iApp, and Ansible! Deploy http virtual server with iRule for 0-day attack.
--------------------------------------------------------------------------------------------------------------------------------

- Under development
- Deploy the Service Discovery iApp and use tags to automatically create and populate F5 BigIP pools.
- Deploy the previous task's iApp programmatically via Ansible.
- Deploy http virtual server with iRule for 0-day attack with Application Services iApp.

Task 8 - Enable Bot protection and autoscale WAF
------------------------------------------------
- Under development

Task 9 - Nuke environment
-------------------------
1.  AWS Console -> Services -> Storage -> S3. Filter for your S3 buckets. My test email is t.marfil@f5.io so I filter on 'marfil'. Delete your two S3 buckets prefaced with ha- and waf-.

2. AWS Console => Services => Compute => EC2. Auto Scaling Groups. Filter on your email address. Same style filter as S3, no special characters. I filter on 'marfil'.

3. Click on 'Instances' tab below. Select your Instance. Actions => Instance Protection => Remove Scale In Protection.

4. From the f5-super-netops terminal:

.. code-block:: bash

   terraform destroy

5. After destroy completes, remove MyKeyPair-[email address]. From the AWS Console -> Services -> NETWORK & SECURITY -> Key Pairs -> Delete MyKeyPair-[email address].

6. Remove User. From the AWS Console -> Services -> Security, Identity & Compliance ->  IAM -> Users. Filter by email address. Delete user.

.. note:: Many thanks to Yevgeniy Brikman for his excellent *Terraform: Up and Running: Writing Infrastructure as Code 1st Edition* that helped me get started. http://shop.oreilly.com/product/0636920061939.do