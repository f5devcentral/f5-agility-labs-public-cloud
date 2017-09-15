Explore the F5 / AWS lab environment
------------------------------------

1. Use the alias aws console link, email address, and shortUrl as password to login to the aws console.

.. image:: ./images/aws-console-login1.png
  :scale: 50%

.. image:: ./images/aws-console-login2.png
  :scale: 50%

https://f5agility2017.signin.aws.amazon.com/console?region=ap-southeast-1

+--------------------------+------------------------------------------------------+
| Parameter                | value                                                |
+==========================+======================================================+
| Account:                 | f5agility2017                                        |
+--------------------------+------------------------------------------------------+
| User Name:               | userxx@f5demo.com, change xx to your student number  |
+--------------------------+------------------------------------------------------+
| Password:                | sames as shortUrl / echo $shortUrl                   |
+--------------------------+------------------------------------------------------+


2. Navigate to Services => Networking & Content Delivery => VPC. Click on # VPCs. In the search field type your user account name. You should see your VPC details. VPC stands for virtual private cloud, this is the slice of the amazon cloud that has been dedicated for your lab environment.

3. In the upper right-hand corner, ensure you are in the correct region. For example: N. Virginia region (us-east-1) is the default.

.. image:: ./images/aws-console-vpc.png
  :scale: 50%

4. Navigate to Services => Compute => EC2 => INSTANCES => Instances. The web application is hosted on webaz1.0 in one availability zone and webaz2.0 in another availability zone. Highlight web-az1.0, in the "Description" tab below note the availability zone. Highlight web-az2.0 and do the same. Select the Tags tab for web-az1.0 and web-az2.0. We will use these tags later in the lab to autodiscover these instances as pool members from a Big-IP VE.

.. image:: ./images/aws-console-ec2-az.png
  :scale: 50%

5. Three Big-IP virtual editions are running:

   - BIGIP1 and BIGIP2 are in a cross-availability zone cluster that was deployed via a CloudFormation template.
   - BIG-IP Autoscale Instance is the first F5 web application firewall provisioned for Application Security Manager with a low, medium, or high starter policy enabled. Depending on configurable traffic thresholds the WAF will scale from 1 to N instances. These thresholds are controlled via an auto scale group policy.

6.  Cloud-init. Version 13 of Big-IP supports cloud-init. Right click on BIGIP1 => Instance Settings => View/Change User Data. Cloud-init is the industry standard way to inject commands into an F5 cloud image to automate all aspects of the on-boarding process: https://cloud-init.io/.

.. image:: ./images/aws-console-cloud-init1.png
  :scale: 50%

.. image:: ./images/aws-console-cloud-init2.png
  :scale: 50%

7. Services => Compute => EC2 => AUTO SCALING => Auto Scaling Groups.
   - In the search filter enter your username. Highlight the waf... auto scaling group.
   - Under the "Scaling Policies" tab below review the policy for scaling up and scaling down.

8. Services => Compute => EC2 => LOAD BALANCING => Load Balancers. In the search filter enter your username. You should see your newly created elastic load balancers running.

   - Choose the tf-elb-userXX load balancer and highlight the "Instances" tab below. This is the load balancer that is in front of your simple web application hosted on web-az1.0 and web-az2.0.
   - Choose the waf-userXX load balancer and highlight the "Instances" tab below. This is the load balancer that is in front of your F5 web application firewall(s).

.. image:: ./images/aws-console-elb1.png
  :scale: 50%
.. image:: ./images/aws-console-elb2.png
  :scale: 50%

9. GitHub. Fully supported F5 Networks Solutions are hosted in the official F5 Networks GitHub repository:

   - https://github.com/f5networks
   - We are running the lab from the f5-super-devops container: https://github.com/f5devcentral/f5-super-netops-container

   - AWS CloudFormation templates: https://github.com/F5Networks/f5-aws-cloudformation

   - Native template formats are also available for Microsoft Azure (arm templates): https://github.com/F5Networks/f5-azure-arm-templates

   - Native template formats are also available for Google Cloud Platform (gdm templates): https://github.com/F5Networks/f5-google-gdm-templates

.. image:: ./images/f5-github.png
  :scale: 50%

10. CloudFormation Templates mock walk-through. CloudFormation templates are the AWS declarative method to deploy full application stacks to AWS.

F5 Virtual Edition can be deployed via CloudFormation Templates and are an F5 officially supported deployment method.

During the previous lab you deployed via Terraform the following F5 CFT Solution.

- "Deploying the BIG-IP in AWS - Clustered 2-NIC across Availability Zones" which supports automatic Big-IQ Licensing (we opted to use hourly billing in the previous lab):

https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/cluster/2nic/across-az-ha

.. image:: ./images/aws-2nic-cluster-across-azs.png
  :scale: 50%

...you also deployed:

- Auto scaling the BIG-IP VE Web Application Firewall in AWS:

https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/solutions/autoscale/waf/

.. image:: ./images/config-diagram-autoscale-waf.png
  :scale: 50%

11. Go to https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/cluster/2nic/across-az-ha.

12. Scroll to and then click the "Launch Stack" icon for "Hourly..."

.. image:: ./images/cft1.png
  :scale: 50%

13. In the "Create Stack" screen, click "Next".

.. image:: ./images/cft2.png
  :scale: 50%

14. This will render the template from within the AWS console. Fill in the first few parameters by choosing from the drop-down menus. The options present were created previously via Terraform. No need to complete the CloudFormation stack here. Terraform has already stuffed these parameters and fired off the completed CloudFormation template. Think about how many steps we've saved by fully automating the solution. Scroll down and click "Cancel"

.. image:: ./images/cft3.png
  :scale: 50%

15. Track things are going well in the AWS management console: Services => Management Tools => CloudFormation template. When done, both of your deployed CloudFormation templates will be Status: CREATE_COMPLETE. Here you can expand and review the steps or troubleshoot if something went wrong.

.. image:: ./images/aws-console-cloudformation.png
  :scale: 50%
