Review the Deployment in AWS Console
================================================================================

Now, you will check the objects that were created by Terraform. The deployment includes the following:

- VPC and Subnets
- Route Tables
- Transit Gateway
- Network Interfaces
- Elastic IP Addresses
- SSH Keypair
- EC2 Instances


Return to your web browser and ensure that you are logged into the AWS Console.


VPC Dashboard
--------------------------------------------------------------------------------
Type ``vpc`` in the AWS Console search box at the top of the page and select **VPC** from the search results.

   .. image:: ./images/aws-vpc-1.png
      :align: left

The VPC Dashboard will show a summary of your resources.

   .. image:: ./images/aws-vpc-1a.png
      :align: left


VPC and Subnets
--------------------------------------------------------------------------------

Click on **Your VPCs** from the left panel menu.

   .. image:: ./images/aws-vpc-2.png
      :align: left

Two (2) **VPCs** were created.

   .. image:: ./images/aws-vpc-3.png
      :align: left


Click on the *sslo-sslo-securitystack* **VPC ID** to view the configuration.

   .. image:: ./images/aws-vpc-4.png
      :align: left

You may ignore the "Failed to load rule groups" error.


Click on **Your VPCs** to return to the VPCs list and then click on the *sslo-sslo-appstack* **VPC ID**.

   .. image:: ./images/aws-vpc-5.png
      :align: left

You may ignore the "Failed to load rule groups" error.

Click on **Subnets** from the left panel menu and confirm that following resources were created:

   .. image:: ./images/aws-vpc-subnets.png
      :align: left


Route Tables
--------------------------------------------------------------------------------
Click on **Route Tables** from the left panel menu and confirm that the following resources were created:

   .. image:: ./images/aws-vpc-rt.png
      :align: left


Internet Gateway
--------------------------------------------------------------------------------
Click on **Internet Gateways** from the left panel menu and confirm that the following resource was created:

   .. image:: ./images/aws-vpc-igw.png
      :align: left


Security Groups
--------------------------------------------------------------------------------
Scroll down in the left panel menu to the **SECURITY** section and click on **Security Groups**.

Confirm that the following resources were created:

   .. image:: ./images/aws-vpc-sg.png
      :align: left


Transit Gateway
--------------------------------------------------------------------------------
Scroll down in the left panel menu to find and click on **Transit Gateways**.

Confirm that the following resources were created:

   .. image:: ./images/aws-vpc-tgw.png
      :align: left


EC2 Dashboard
--------------------------------------------------------------------------------
Type ``ec2`` in the AWS Console search box at the top of the page and select **EC2** from the search results.

   .. image:: ./images/aws-ec2-1.png
      :align: left


The EC2 Dashboard will show a summary of your resources.

   .. image:: ./images/aws-ec2-2.png
      :align: left


Network Interfaces
--------------------------------------------------------------------------------
Scroll down in the left panel menu to find and click on **Network Intefaces**.

Confirm that the following resources were created:

   .. image:: ./images/aws-ec2-net.png
      :align: left


The **BIG-IP** (SSL Orchestrator) uses 7 NICs (management, external, internal, dmz1, dmz2, dmz3, dmz4).

The first **inspection device** uses 3 NICs (management, dmz1, dmz2).

The second **inspection device** uses 3 NICs (management, dmz3, dmz4).

The **webapp** server uses 1 NIC (application).


Elastic IP Addresses
--------------------------------------------------------------------------------
Click on **Elastic IPs** from the left panel menu and confirm that the following resources were created:

   .. image:: ./images/aws-ec2-eip.png
      :align: left


SSH Key
--------------------------------------------------------------------------------
Click on **Key Pairs** from the left panel menu and confirm that the following resource was created:

   .. image:: ./images/aws-ec2-keypair.png
      :align: left


EC2 Instances
--------------------------------------------------------------------------------
Click on **Instances** from the left panel menu and confirm that the following resources were created:

   .. image:: ./images/aws-ec2-instance-1.png
      :align: left

   |

   .. attention::

     The **sslo-vm_bigip_sslo** instance might still be in **Initializing** state (look at the **Status check** column). Eventually, this will transition to **2/2 checks passed**.

     .. image:: ./images/aws-ec2-instance-2.png
         :align: left

     Do not proceed until the **Status check** column is *green* for all instances.
