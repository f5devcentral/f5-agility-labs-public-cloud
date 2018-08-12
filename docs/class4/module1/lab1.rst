Create AWS VPC and Networking
-----------------------------

The first module is to create the AWS VPC and required networking. Module 2 will build upon this deployment.

The following diagram shows a basic multi-NIC deployment of BIG-IP VE in an Amazon Virtual Private Cloud (VPC).

Complete the tasks in this guide to create this deployment.

.. figure:: ../images/multi_deploy1.png


|
This deployment shows three subnets:

- An external, public subnet, where you'll create a virtual server to accept Internet traffic.
- An internal, private subnet, where your application servers live.
- A management subnet, where you can access the BIG-IP Configuration utility; you use the Configuration utility to configure BIG-IP VE.

Traffic flows from clients through BIG-IP VE to application servers.

You create all IP addresses and network interfaces in AWS. Then in BIG-IP VE, you create corresponding objects for the same IP addresses, represented by the shaded boxes in the diagram.

Environment
-----------
All labs as part of this class will be done through the AWS Management Console. An account has been created for you.
|login|

- Account ID or alias <prepopulated>
- IAM user name <Student#> where # is the number assigned during class
- Password <Given in classroom>

.. figure:: ../images/login_example.png

**Important! After login, ensure all you are in the US East (N. Virginia) region!**



Create a VPC with multiple subnets using a CFT
``````````````````````````````````````````````

You will utilize an instructor provided Cloud Formation Template (CFT) to deploy the required networking in AWS. This deployment will be as shown in the diagram above.

1. Launch the CFT process for creating the VPC and required networking by clicking on this link - |VPC-CFT|
2. Ensure you are in the **N. Virginia** region
3. At the **Select Template** page, notice that the URL for the template is already entered - select **Next**.
4. Enter a **Stack name** of :guilabel:`Student#-VPC-CFT` and select **Next**
5. At the **Options** page, leave all defaults and select **Next**
6. At the **Review** page, select **Create**
7. You're taken to the list of CFTs being deployed, refresh the page and watch the status of your's until it says **Create_Complete**

This concludes Module 1 of Lab 1. Next we will deploy the BIG-IP into this VPC that you've just created.



.. |github| raw:: html

   <a href="https://github.com/F5Networks" target="_blank">https://github.com/F5Networks</a>

.. |awskeypair| raw:: html

   <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#having-ec2-create-your-key-pair" target="_blank">create one in AWS</a>

.. |login| raw:: html

   <a href="https://854140829363.signin.aws.amazon.com/console" target="_blank">https://854140829363.signin.aws.amazon.com/console</a>

.. |VPC-CFT| raw:: html

   <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?templateURL=https://s3-us-west-1.amazonaws.com/agility2018/VPC_with_MGMT_SG_6" target="_blank">F5 AWS VPC Deployment</a>

