Deploy the BIG-IP
-----------------

In Module 2 we will deploy the BIG-IP into the AWS VPC created in Module 1.

F5 publishes CFTs on a regular basis to Github.

Launch BIG-IP into existing VPC
```````````````````````````````

We will use the instructor provided CFT to launch a BIG-IP into the VPC that already exists.

First, we need to create and save a key pair.

#. In the AWS Management Console, navigate to **EC2** and then under **Network & Security** to **Key Pairs**
#. Click **Create Key Pair** and name it :guilabel:`Student#-BIG-IP`.
#. Click **Create** and it will download the :guilabel:`Student#-BIG-IP.pem` file to your local machine. Be sure to keep track of this file as you will need it to access the BIG-IP later.
#.  You will need to change the permissions of the :guilabel:`Student#-BIG-IP.pem` key pair. On a MAC, open a terminal and go to the folder you saved the :guilabel:`Student#-BIG-IP.pem` key pair. To change the file permissions type:

  :guilabel:`chmod 400 Student#-BIG-IP.pem`

Next, we're ready to deploy the CFT.

#. Go to: |CFT-template|
#. At the **Select Template** page, ensure you are still in the same region where you created your VPC, note the template URL is already selected, and click **Next**.
#. For **Stack name** enter a value of :guilabel:`Student#-BIG-IP-CFT`.
#. In the **VPC** in the drop down, find your :guilabel:`Student#-VPC-CFT` (you may have to scroll down the list).
#. For the **Management Subnet AZ1** select :guilabel:`Student#-VPC-CFT-MgmtSubnet`.
#. Similarly, for **Subnet1** and **Subnet2** assign the :guilabel:`Student#-VPC-CFT-External Subnet` and :guilabel:`Student#-VPC-CFT-Internal Subnet` subnets from the drop down.
#. Ensure the **BIG-IP Image Name** is set to :guilabel:`AWAF25Mbps`.
#. Ensure the **AWS Instance Size** is set to :guilabel:`t2.large`.
#. For the **SSH Key** utilize the :guilabel:`Student#-BIG-IP` key in the drop down.
#. In the **Source Address(es) for Management Access**, enter :guilabel:`64.251.121.0/24`.
#. in the **Source Address(es) for Web Application Access (80/443)** field, enter :guilabel:`0.0.0.0/0`.
#. Leave all other fields at default values and select **Next**.
#. Leave all fields in the **Options** page at defaults and select **Next**.
#. Review the settings, check the **I acknowledge that AWS CloudFormation might create IAM resources** box and click **Create**.
#. Refresh the page to see the status of the deployment. 
#. Wait until the status of the CFT shows :guilabel:`CREATE_COMPLETE`.


Set the admin password for BIG-IP VE
````````````````````````````````````
To initially change the password for the BIG-IP management utility we need to connect via SSH and then modify the admin password.

#. Navigate to **EC2 -> Network Interfaces** and filter for :guilabel:`Student#-BIG-IP`. Find **Management** interface of your BIG-IP instance . Note the **IPv4 Public IP** address for the **Management** interface.

.. figure:: ../images/mgmt-public-ip.png

#. You can connect using an SSH utility - make sure to use :guilabel:`admin` as the username (do not use ``root``) and the **Management IPv4 Public IP** from the previous step. Use the **Student#-BIG-IP.pem** key pair you saved when you created the instance in Lab 1. For example:

    :guilabel:`ssh -i Student#.pem admin@<IPv4-Public-IP>`

#.  After connecting via SSH issue the command :guilabel:`modify auth password admin` - change the admin password to one that you will remember
#.  Save the password change by issuing the command :guilabel:`save sys config`
#.  You can now connect to the BIG-IP Web UI on HTTPS using the **IPv4 Public IP** for the **Management** interface (bypass the self-signed cert warning) and use the credentials :guilabel:`admin/<password-from-step-4>`
#.  Once logged in to the F5 management console click on **System -> Resource Provisioning**.
#.  Select :guilabel:`ASM`, :guilabel:`Fraud Protection Service`, and :guilabel:`iRules Language Extensions (iRulesLX)`.
#.  Unselect :guilabel:`LTM`
#.  Click on **Submit** and then **OK**.  The admin console will be inaccessible for a couple minutes as the new options are enabled.


.. |github| raw:: html

   <a href="https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/standalone/3nic/existing-stack/payg" target="_blank">F5's Github repository</a>

.. |CFT-template| raw:: html

   <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?templateURL=https:%2F%2Fs3-external-1.amazonaws.com%2Fcf-templates-k2dflj3mk02p-us-east-1%2F2018201LuF-template191z9ht7gde7&redirectId=DesignTemplate" target="_blank">F5 Advanced WAF Cloud Formation Template</a>