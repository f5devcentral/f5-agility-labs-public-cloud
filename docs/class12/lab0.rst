Lab Guide PC211

0.0 Getting Started
===================

This lab is an overview of how to deploy an automated version of the
Secure Azure Computing Architecture (SACA). One of many Secure Cloud
Architectures available from F5. This lab will use Azure Resource
Manager (ARM) Templates to deploy a Highly Available Pair of BIG-IPs.

0.1 General information 
-----------------------

This lab is hosted directly in Microsoft Azure. Each student should
receive an email sent to their agility registration address before the
lab begins. This email will contain the following information:


Logon URL: https://portal.azure.com

Username: SCAStudent______\_ (Example: SCAStudent37)

Password: \_________________\_ (The initial password will be in the
email, and you will be required to change it.)

You will have the ability to deploy Virtual Resources, that is the point
of the lab. Please only deploy the resources you are directed to deploy
in the lab guide.

In addition, you should receive an email from UDF that looks something like this:
|image1|

And if you have never registered for UDF before, also an email like this providing you with your username and temporary password:
|image2|

0.2 Lab Topology
----------------

|image3|
------------------------------------------------------------------

The lab when deployed will consist of an HA pair of 2 BIG-IPs, A Linux
Jump Box, a Windows Jump Box and a host of Azure configuration items we
will explore as part of Module 3.

0.3 Lab Module Overview
-----------------------

Lab Module 1 
~~~~~~~~~~~~

Module 1 is done together with the Lab Instructor. It is an exploration
of Azure, its main components, and the automation option that are
available to us. Estimated Time 10 Minutes.

Lab Module 2
~~~~~~~~~~~~

Module 2 is on your own. This lab launches an ARM template to deploy an
HA pair of BIG-Ips. The Instructor will demo the deployment and the key
options and configurations items to be aware of. Then you can complete
module 2 on your own.

Lab Module 3
~~~~~~~~~~~~

Module 3 is done together with the Lab Instructor. Lab 3 is an
exploration of all the components deployed in the ARM Template. We will
ensure functionality and that the Management Plane is accessible via SSH
and RDP.

Lab Module 4
~~~~~~~~~~~~

Module 4 is done on your own. Module 4 enables access to the data plane
via the second public IP address deployed in the ARM Template. You will
configure Azure Network Security Groups and Load Balancers to ensure
traffic can reach a referenced web server iRule running on a VIP.

.. _section-1:
.. |image1| image:: media/image1.png
  :scale: 75 %
.. |image2| image:: media/image2.png
  :scale: 75 %
.. |image3| image:: media/image3.png
  :scale: 70 %