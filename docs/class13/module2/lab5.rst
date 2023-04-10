Review the Deployment in AWS Console
================================================================================

Now, you will check the objects that were created by Terraform. The deployment includes the following:

- VPC and Subnets
- Route Tables
- Transit Gateway
- Internet Gateway
- NAT Gateway
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

   .. image:: ./images/aws-vpc-2.png
      :align: left

|

VPC and Subnets
--------------------------------------------------------------------------------

Click on **Your VPCs** from the left panel menu.

   .. image:: ./images/aws-vpc-3.png
      :align: left

|

Two (2) **VPCs** were created.

   .. image:: ./images/aws-vpc-4.png
      :align: left

|

Click on the *f5lab-hub-vpc* **VPC ID** to view the configuration.

   .. image:: ./images/aws-vpc-5.png
      :align: left

You may ignore the "Failed to load rule groups" error.

|

Click on **Your VPCs** to return to the VPCs list and then click on the *f5lab-app-vpc* **VPC ID**.

   .. image:: ./images/aws-vpc-6.png
      :align: left

You may ignore the "Failed to load rule groups" error.

|

Click on **Subnets** from the left panel menu and confirm that following resources were created:

   .. image:: ./images/aws-vpc-subnets.png
      :align: left

|

Route Tables
--------------------------------------------------------------------------------
Click on **Route Tables** from the left panel menu and confirm that the following resources were created:

   .. image:: ./images/aws-vpc-rt.png
      :align: left

|

Internet Gateway
--------------------------------------------------------------------------------
Click on **Internet Gateways** from the left panel menu and confirm that the following resource was created:

   .. image:: ./images/aws-vpc-igw.png
      :align: left

|

NAT Gateway
--------------------------------------------------------------------------------
Click on **NAT Gateways** from the left panel menu and confirm that the following resource was created:

   .. image:: ./images/aws-vpc-ngw.png
      :align: left

|

Security Groups
--------------------------------------------------------------------------------
In the left panel menu **Security** section, click on **Security Groups**. Confirm that the following resources were created:

   .. image:: ./images/aws-vpc-sg.png
      :align: left

|

Transit Gateway
--------------------------------------------------------------------------------
Scroll down in the left panel menu to find and click on **Transit Gateways**.

Confirm that the following resources were created:

   .. image:: ./images/aws-vpc-tgw.png
      :align: left

|

EC2 Dashboard
--------------------------------------------------------------------------------
Type ``ec2`` in the AWS Console search box at the top of the page and select **EC2** from the search results.

The EC2 Dashboard will show a summary of your resources.

   .. image:: ./images/aws-ec2-dashboard.png
      :align: left

|


SSH Key
--------------------------------------------------------------------------------
Scroll down in the left panel menu to find and click on **Key Pairs** from the left panel menu and confirm that the following resource was created:

   .. image:: ./images/aws-ec2-keypair.png
      :align: left

|

Network Interfaces
--------------------------------------------------------------------------------
Click on **Network Intefaces**.

Confirm that the following resources were created:

   .. image:: ./images/aws-ec2-net.png
      :align: left


Each **BIG-IP** has 3 NICs (management, external, internal).

Each App Server uses 1 NIC.

|

Elastic IP Addresses
--------------------------------------------------------------------------------
Click on **Elastic IPs** from the left panel menu and confirm that the following resources were created:

   .. image:: ./images/aws-ec2-eip.png
      :align: left

|

EC2 Instances
--------------------------------------------------------------------------------
Click on **Instances** from the left panel menu and confirm that the following resources were created:

   .. image:: ./images/aws-ec2-instance-1.png
      :align: left

|

.. attention::

   Instances might still be in **Initializing** state (look at the **Status check** column). Eventually, this will transition to **2/2 checks passed**.

   Do not proceed until the **Status check** column is *green* for all instances.

|

**BIG-IP #1**

Click on the **bigip1** instance to view details, then click on the **Networking** tab to view network settings.

   .. image:: ./images/aws-ec2-instance-2.png
      :align: left

|

Scroll down to see the NIC and Elastic IPs that are associated with this BIG-IP instance.

   .. image:: ./images/aws-ec2-instance-3.png
      :align: left

|

**BIG-IP #2**

Click on the **bigip2** instance to view details, then click on the **Networking** tab to view network settings.

   .. image:: ./images/aws-ec2-instance-4.png
      :align: left

|

**App Server #1**

Click on the **appsvr1** instance to view details.

   .. image:: ./images/aws-ec2-instance-5.png
      :align: left

|

**App Server #2**

Click on the **appsvr2** instance to view details.

   .. image:: ./images/aws-ec2-instance-6.png
      :align: left

