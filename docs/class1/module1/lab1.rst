Task 0 - Prerequisites
----------------------

.. important:: Your student account, and short URL path will be announced at the start of the lab.

- Though the environment runs on a shared AWS account, every student will build and work in a dedicated AWS VPC.

- For this lab, a Ravello Windows 10 remote desktop jump host and Linux web based shell will be provided as a consistent starting point.

- Alternatively, you can run the lab from any laptop or workstation with:

  - a working installation of docker on any operating system
  - an Internet connection
  - a web browser compatible with the aws web console. Any of the aws supported browsers will do:
    https://aws.amazon.com/premiumsupport/knowledge-center/browsers-management-console/

1. Install Docker:

   - Mac:
     https://docs.docker.com/docker-for-mac/

   - Linux:
     https://docs.docker.com/engine/installation/

   - Windows:
     https://docs.docker.com/docker-for-windows/install/

.. warning:: Docker for Windows is based on Microsoft Hyper-V and will disable VMWware Workstation if running on the same machine. If you have VMWare Workstation, do not install Docker for Windows. Stick to the webshell.

Task 1 - Prepare the F5-Super-Netops container, create your AWS lab account, and build the AWS lab environment
--------------------------------------------------------------------------------------------------------------

Let's assume:

- Student account name = "user01@f5.io"
- Short URL path = "abc123"
- Big-IQ License Manager = "null" because it's not used.

1. From the lab web shell, pull down the f5-super-netops container image, launch the f5-super-netops docker container in interactive mode, map port 22 on the container with 2222 on the host, and port 80 on the container with 8080 on the host.

Cut and past the command below to accomplish the steps above.

.. code-block:: bash

   docker run -p 8080:80 -p 2222:22 -it -e SNOPS_AUTOCLONE=0 f5devcentral/f5-super-netops-container:base

2. Export your student account and short URL path variables. Your student account will be used to create an AWS console login and tag all of the objects created in AWS so you can quickly identify them when working in the AWS web console. The short URL path will be used to grant access to the shared aws account both via the AWS API and as the password for the AWS web console. Replace the emailid and shortUrl values below with the student account name and decryption password assigned to you at the start of the lab.

Cut and paste the commands below to accomplish the steps above.
   
.. code-block:: bash

   export emailid=user01@f5.io
   export shortUrl=abc123
   printenv

...confirm the exported variables are correct.

3. Create an AWS account and other onboarding steps:

- Change to your home directory. 
- Clone the git repository for this lab.
- Change to the working directory.
- Run the start script.

Cut and paste the commands below to accomplish the steps above.
   
.. code-block:: bash

   cd ~
   git clone https://github.com/TonyMarfil/marfil-f5-terraform
   cd ~/marfil-f5-terraform/
   source ./start

.. attention:: For a smooth ride, always invoke commands as root, from inside the cloned git repository. To check you're in the right place:

.. code-block:: bash
   
   pwd

...output should read "/root/marfil-f5-terraform"


4. Invoke terraform. Enter "null" when prompted for the IP address of the Big-IQ License Manager. We will use utility licensing.

.. code-block:: bash

   terraform plan

   terraform apply

5. Once "terraform apply" completes, you can test your web server instances and ELB are up:

.. code-block:: bash

   while :; do curl `terraform output elb_dns_name`; sleep 1; done

You should see a reply 'Hello, World'. Hit <ctrl>+C to stop.

When 'terraform apply' completes, note the \*\*aws_alias\*\* and vpc-id values. Open up your \*\*aws_alias\*\* link in a browser and login to the AWS console with the email address and password you created during the install. You can always get these values by invoking terraform output with the variable name:

.. code-block:: bash

   terraform output **aws_alias**
   terraform output vpc-id

.. warning:: terraform apply will take five minutes to complete, but the environment will not be ready for another 15 minutes as the Big-IP virtual editions and supporting infrastructure wake up. In the meantime, we can begin to explore the AWS lab environment.

=================================

Task 2 - Login to the AWS console and explore the F5 / AWS lab environment
--------------------------------------------------------------------------

1. CloudFormation templates are the AWS declarative method to deploy full application stacks to AWS. F5 Virtual Edition can be deployed via CloudFormation Templates and are an F5 officially supported deployment method.

- Auto scaling the BIG-IP VE Web Application Firewall in AWS:

 https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/solutions/autoscale/waf/

.. image:: ./images/config-diagram-autoscale-waf.png

- "Deploying the BIG-IP in AWS - Clustered 2-NIC across Availability Zones" which supports automatic Big-IQ Licensing:

 https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/cluster/2nic/across-az-ha

.. image:: ./images/aws-2nic-cluster-across-azs.png

2. Use the alias aws console link, email address and password you created earlier to login to the aws console. Navigate to Services => Networking & Content Delivery => VPC. Click on # VPCs. In the search field type your user account name. You should see your VPC details. VPC stands for virtual private cloud, this is the slice of the amazon cloud that has been dedicated for your lab environment.

#. In the upper right-hand corner, ensure you are in the correct region. For example: N. Virginia region (us-east-1) is the default.

#. Track things are going well in the AWS management console: Services => Management Tools => CloudFormation template. When done, both of your deployed CloudFormation templates will be Status: CREATE_COMPLETE. Here you can expand and review the steps or troubleshoot if something went wrong.

#. The web application is hosted on webaz1.0 in one availability zone and webaz2.0 in another availability zone. Highlight web-az1.0, in the "Description" tab below note the availability zone. Highlight web-az2.0 and do the same.

#. Three Big-IP virtual editions are running:

  - BIGIP1 and BIGIP2 are in a cross-availability zone cluster that was deployed via a CloudFormation template.
  - BIG-IP Autoscale Instance is the first F5 web application firewall provisioned for Application Security Manager with a low, medium, or high starter policy enabled. Depending on configurable traffic thresholds the WAF will scale from 1 to N instances. These thresholds are controlled via an auto scale group policy.

7.  Cloud-init. Version 13 of Big-IP supports cloud-init. Right click on BIGIP1 => Instance Settings => View/Change User Data. Cloud-init is the industry standard way to inject commands into an F5 cloud image to automate all aspects of the on-boarding process: https://cloud-init.io/.

#. Services => Compute => EC2 => AUTO SCALING => Auto Scaling Groups.
   - In the search filter enter your username. Highlight the waf... auto scaling group.
   - Under the "Scaling Policies" tab below review the policy for scaling up and scaling down.

#. Services => Compute => EC2 => LOAD BALANCING => Load Balancers. In the search filter enter your username. You should see your newly created elastic load balancers running.

   - Choose the tf-elb-userXX load balancer and highlight the "Instances" tab below. This is the load balancer that is in front of your simple web application hosted on web-az1.0 and web-az2.0.
   - Choose the waf-userXX load balancer and highlight the "Instances" tab below. This is the load balancer that is in front of your F5 web application firewall(s). 

#. GitHub. Fully supported F5 Networks Solutions are hosted in the official F5 Networks GitHub repository:

   - https://github.com/f5networks
   - We are running the lab from the f5-super-devops container: https://github.com/f5devcentral/f5-super-netops-container

   - AWS CloudFormation templates: https://github.com/F5Networks/f5-aws-cloudformation

   - Native template formats are also available for Microsoft Azure (arm templates): https://github.com/F5Networks/f5-azure-arm-templates

   - Native template formats are also available for Google Cloud Platform (gdm templates): https://github.com/F5Networks/f5-google-gdm-templates

Task 3 - Verify a healthy F5 environment
----------------------------------------

1. Run the handy lab-info command to quickly identify the IP addresses assigned to your environment.

.. code-block:: bash

   ./scripts/lab-info

.. code-block:: bash

   WAF ELB
     URL: https://waf-user01f5io-499431932.us-east-1.elb.amazonaws.com

   web-az1.0
     PRIVATE IP:	10.0.1.221

   web-az2.0
     PRIVATE IP:	10.0.2.221

   Big-IP2: ha-user01f5io-vpc-74c7a70d
     MGMT IP:	34.194.27.11
     VIP IP:	10.0.2.252

   BIG-IP Autoscale Instance: waf-user01f5io
     MGMT IP:	54.165.15.2

   Big-IP1: ha-user01f5io-vpc-74c7a70d
     MGMT IP:	34.230.189.240
     VIP IP:	10.0.1.37
     Elastic IP:	34.196.122.217

Sample output above. lab-info will quickly orient you around our deployment. All of the same information is available via the AWS Console, the lab-info script is here for convenience.

   - We have an application behind an F5 autoscale WAF that can be reached by the WAF ELB URL.

   - The web-az1.0 and webaz2.0 PRIVATE IP addresses will soon be configured as pool members for our Big-IP HA cluster.

   - Big-IP1 and Big-IP2 are configured as a high availability cluster across two separate availability zones. Only the active Big-IP will have an Elastic IP address assigned. Configuration changes to the active unit will automatically propagate to the standby unit. During an outage, even one affecting an entire availability zone, the Elastic IP will 'float' over to the unit that is not affected.


   - BIG-IP Autoscale Instance is a single NIC deployment WAF with the MGMT IP address identified.

2. From the f5-super-netops container test out application behind the auto-scale waf is up.

.. code-block:: bash

   curl -k https://waf-user01f5io-499431932.us-east-1.elb.amazonaws.com

Hello, World

...this is a sign that things went well and we can start configuring the Big-IPs to responsibly fulfill our part of the shared responsibility security model: https://aws.amazon.com/compliance/shared-responsibility-model/

.. image:: https://d0.awsstatic.com/security-center/NewSharedResponsibilityModel.png

Task 4 - Configuration Utility (Web UI) access
----------------------------------------------

1. Identify the management IP address of each of the three BigIP instances that we created. By defaultt, F5 cloud instances are locked down to ssh key access only. Let's create an admin password so we can login via the configuration utility (web ui). Assuming you are user01 and the management IP address of your F5 instance is 54.165.15.2.

.. code-block:: bash

   ssh -i ./MyKeyPair-user01@f5.io.pem admin@54.165.15.2

2. Create an admin password.

.. code-block:: bash

   modify auth user admin password mylabpass

3. Complete the step above for *all three* Big-IP instances:

   - Big-IP2: ha-user01f5io-vpc-74c7a70d
       MGMT IP:	34.194.27.11

   - BIG-IP Autoscale Instance: waf-user01f5io
       MGMT IP:	54.165.15.2

   - Big-IP1: ha-user01f5io-vpc-74c7a70d
       MGMT IP:	34.230.189.240


Task 5 - Deploy the Service Discovery iApp on a BigIP Cluster across two Availability Zones
-------------------------------------------------------------------------------------------
1. Login to the active Big-IP1 configuration utility (web ui). Using the examples in our lab-info output: http://34.230.189.240.

#. Navigate to iApps. The "HA_Across_AZs" iApp will already be deployed in the Common partition and is automatically configured when you deploy the HA CloudFormation template across availability zones.

#. The Service Discovery iApp will automatically discover and populate nodes in the cloud based on tags.

#. From the configuration utility (web ui) of Big-IP1. iApps => Application Services => Create... 

+----------------------------------------------------------------------------+----------------------------------+
| Question                                                                   | value                            |
+============================================================================+==================================+
| Name                                                                       | service_discovery                |
+----------------------------------------------------------------------------+----------------------------------+
| Template                                                                   | f5.service.discovery             |
+----------------------------------------------------------------------------+----------------------------------+
| Pool                                                                                                          |
+----------------------------------------------------------------------------+----------------------------------+
| What is the tag key on your cloud provider for the members of this pool?   | application                      |
+----------------------------------------------------------------------------+----------------------------------+
| What is the tag value on your cloud provider for the members of this pool? | f5app                            |
+----------------------------------------------------------------------------+----------------------------------+
| Do you want to create a new pool or use an existing one?                   | Create new pool...               |
+----------------------------------------------------------------------------+----------------------------------+
| Application Health                                                                                            |
+----------------------------------------------------------------------------+----------------------------------+
| Create a new health monitor or use an existing one?                        | http                             |
+----------------------------------------------------------------------------+----------------------------------+


5. Local Traffic => Pools => track the newly created service_discovery_pool. Within 60 seconds it should light up green. The service_discovery iApp has discovered and auto-populated the service_discovery_pool with two web servers.


Task 6 - Deploy an AWS High-Availability-aware virtual server across two Availability Zones
---------------------------------------------------------------------------------------------

1. From the Linux web shell, run the lab-info utility. This is a quick way to gather the details you'll need to configure the AWS high-availability-aware TCP virtual server.

#. Login to the active Big-IP1 configuration utility (web ui). Using the examples in our lab-info output: https://34.230.189.240.

#. The "HA_Across_AZs" iApp will already be deployed in the Common partition.

#. The "service_discovery" iApp will already be deployed as well.

#. Download the latest iApp package from https://s3.amazonaws.com/f5-marfil/iapps-1.0.0.468.0.zip.

#. Extract \\TCP\Release_Candidates\\f5.tcp.v1.0.0rc2.tmpl. This is the tested version of the iApp.

#. Import f5.tcp.v1.0.0rc2.tmpl to the primary BigIP. The secondary BigIP should pick up the configuration change automatically.

#. Deploy an iApp using the f5.tcp.v1.0.0rc2.tmpl template.

#. Configure iApp:

    - Select "Advanced" from "Template Selection"

    - Traffic Group: UNCHECK "Inherit traffic group from current partition / path"

+--------------------------------------------------------------------------------------------------------------+----------------------------------+
| Question                                                                                                     | value                            |
+==============================================================================================================+==================================+
| Name:                                                                                                        | virtual_server_1                 |
+--------------------------------------------------------------------------------------------------------------+----------------------------------+
| High Availability. What IP address do you want to use for the virtual server?                                | VIP IP of Big-IP1                |
+--------------------------------------------------------------------------------------------------------------+----------------------------------+
| What is the associated service port?                                                                         | HTTP(80)                         |
+--------------------------------------------------------------------------------------------------------------+----------------------------------+
| What IP address do you wish to use for the TCP virtual server in the other data center or availability zone? | VIP IP of Big-IP2                |
+--------------------------------------------------------------------------------------------------------------+----------------------------------+
| Which servers are part of this pool?                                                                         | Private IP of web-az1.0 Port: 80 |
+                                                                                                              +----------------------------------+
|                                                                                                              | Private IP of web-az2.0 Port: 80 |
+--------------------------------------------------------------------------------------------------------------+----------------------------------+

      .. note:: The preconfigured HA_Across_AZs iApp has both IP addresses for the virtual servers prepopulated. The virtual server IP addresses configured here must match the virtual server IP address configured in the HA_Across_AZs iApp.


**Finished!**

10. Login to the standby BigIP configuration utility (web ui) and confirm the changes are in sync.

#. Confirm the virtual server is up!

.. code-block:: bash

   curl http://34.196.122.217

...watch for Hello, World response from Big-IP1.

   StatusCode        : 200

   StatusDescription : OK

   Content           : Hello, World

   ...


.. code-block:: bash

   ./scripts/lab-info

12. AWS Console => Services => Compute => EC2. Right click on the active BigIP1 instance => Instance State => Reboot. In a few seconds, the AWS console and the elastic IP will 'float' over to the second BigIP.

.. code-block:: bash

   ./scripts/lab-info

.. code-block:: bash

   curl http://52.205.85.86

...watch for Hello, World response from Big-IP2. Traditional HA failover relies on Layer 2 connectivity and a heartbeat to trigger a fail-over event and move a 'floating IP' to a new active unit. There is no Layer 2 connectivity in the cloud across availability zones. The Big-IP will detect an availability zone outage or trouble with a Big-IP VE and the elastic IP will 'float' over to the new active device as you just saw.

Task 7 - iRules in AWS
----------------------

Task 8 - Autoscale WAF
----------------------

1. Navigate to Services => AUTO SCALINE => Auto Scaling Groups. Filter on your username and select your waf-userxx... auto scaling group.
2. Select the 'Instances' tab below, and select your Instance ID (there should be only one). If your instance is "Protected from... Scale in" then it will always stay up regardless of scale up/down thresholds configured.
3. Select the Scaling Polices tab. These policies were deployed via the CloudFormation template and can be changed via the CloudFormation template.
4. Login to the active BIG-IP Autoscale Instance MGMT IP **on port 8443** configuration utility (web ui). Using the examples in our lab-info output in earlier tasks: https://54.165.15.2:8443.

.. code-block:: bash

   ./scripts/lab-info

5. From the f5-super-netops container, let's generate launch some traffic against the application behind our WAF and watch it autoscale to service the surge! Replace the https://waf-userxx... in the command below with the one in the output of lab-info and don't miss that you have tack on a / at the end of the url.

.. code-block:: bash

   ab -t 120 -c 100 https://waf-user01f5io-xxxxxxxxx.us-east-1.elb.amazonaws.com/

6. Navigate to Service => INSTANCES => Instances. Filter on your username and after 60 seconds (the lowest configurable time threshold) hit refresh to see your 2nd autoscale WAF instance starting.

Task 9 - Nuke environment
-------------------------
1.  AWS Console => Services => Storage => S3. Use your user account to filter for your S3 buckets. For example: 'user01'. Delete your two S3 buckets prefaced with ha- and waf-.

2. AWS Console => Services => Compute => EC2. Auto Scaling Groups. Use same filter as above.

3. Click on 'Instances' tab below. Select your Instances. Actions => Instance Protection => Remove Scale In Protection from any instances that are protected.

4. From the f5-super-netops terminal:

.. code-block:: bash

   terraform destroy

   Do you really want to destroy?
     Terraform will delete all your managed infrastructure.
     There is no undo. Only 'yes' will be accepted to confirm.

     Enter a value: yes

   var.bigiqLicenseManager
     Management IP address of the BigIQ License Manager

     Enter a value: null

Answer 'yes' and 'null' when prompted.

5. The end.

.. note:: Many thanks to Yevgeniy Brikman for his excellent *Terraform: Up and Running: Writing Infrastructure as Code 1st Edition* that helped me get started. http://shop.oreilly.com/product/0636920061939.dos
