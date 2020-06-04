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

0.2 Lab Topology
----------------

|A screenshot of a cell phone Description automatically generated|
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

0.4 Initial Login for Azure
---------------------------

Go to https://portal.azure.com/

You may need to log out of your existing Azure Account to log in with
the test account. Using an incognito mode browser window should work as
well.

Enter the Username and password from the email. It should be similar to:
SCAStudent##@f5custlabs.onmicrosoft.com where ## is your student number.

|image1|

Click Next.

You will be prompted to change your password

|image2|

Enter your old password and a new password of your choice twice.

Once completed you should be at the Azure Home Page for the F5 Customer
Labs Subscription. It should say so in the upper right-hand corner:

|image3|

If you have an issue logging in, need a password reset, or are in the
wrong subscription please let a lab assistant know immediately!

.. _section-1:

1.0 Lab Module 1 Exploring Our Deployment Options
=================================================

(We will do this together so just follow along with the Instructor, the
below info is for your later reference).

Open a browser and navigate to
https://github.com/f5devcentral/f5-azure-saca

This is the Github repository for the Secure Azure Computing
Architecture.

Scroll down the page until you get to the **Installation** Section.

There are 12 different versions of this ARM Template and they break down
as follows:

-  Azure for Government or Azure Commercial (we will be deploying in
   Azure **Commercial**)

-  1 Tier or 3 Tier use case. We will cover both in the lab, but we will
   be deploying the **1 Tier** for cost, time and simplicity purposes.

-  Lastly there are three licensing types: Bring Your Own License
   (BYOL), Pay As You Go (PAYG) or BIG-IQ Licensing that can utilize a
   preexisting BIG-IQ license manager and leverage ELA or Subscription
   based licensing. We will be deploying the **PAYG** version, so we
   don’t have to type out license keys by hand!

..

   Find the SACA v2 Azure Commercial Section (light blue not dark blue).

   Under that, find the 1 Tier 3-Nic use case

   Under that Find the PAYG Option. **Do not click it yet!**

|image4|

Once you have identified your target, scroll back up to the top and
let’s look at the repository itself.

|image5|

Find and click on the SACAv2 Folder, then inside of that Find and Click
on the AS3 folder.

|image6|

You should see 3 .json files. Click on the **paygsccaBaseline.json** and
let’s look at what’s inside.

|image7|

This is an AS3 template, which is a declarative API call for a set of
configurations we want to deploy to the BIG-IP. Take a look around and
notice we are setting up 3 Virtual Servers, 2 pools and one iRule.

Can you tell what partition they were deployed into?

|image8|

It is all being deployed into a partition called **mgmt**, this will be
important later.

**End of Module 1**

.. _lab-module-2-1:

2.0 Lab Module 2
================

Ensure you are logged into the LF5 Customer Labs Azure Subscription. It
should say so in the upper right-hand corner.

|image9|

Open a second browser tab and navigate to
https://github.com/f5devcentral/f5-azure-saca if you are not there
already.

Scroll down the page until you get to the **Installation** Section.

   Find the SACA v2 Azure Commercial Section (light blue not dark blue).

   Under that, find the 1 Tier 3-Nic use case

   Under that Find the PAYG Option.

|image10|

Click the PAYG option! A new tab should open containing an ARM template
in Azure.

Ensure the subscription is **f5-AZR_4261_SALES_LAB_01**

Create a New Resource Group by clicking Create New.

|image11|

Then type “RG” and your student number, then click ok.

|image12|

Next enter the password: **Password11!!** For both the BIG-IP Admin and
Windows Admin password. There are restricted password characters in
Azure, so it is easier to use a password we know does not contain
restricted characters.

|image13|

Change the **DNS label** to be RG\ *firstname*\ ## where ## matches your
student number. Example: RGPaul60. **It is critical that this value is
unique.**

|image14|

Change the **Number of External IPs** to 2.

|image15|

Change the **BIG-IP version** to **15.0.100000.**

|image16|

Change **STIG Device** to **False.**

|image17|

**Click the checkbox** next to **I agree to the terms and conditions
stated above,** and then **click Purchase**

|image18|

3.0 Lab Module 3 Exploring the SACA components
==============================================

(We will do this together so just follow along with the Instructor, the
below info is for your later reference).

**Go to**\ https://portal.azure.com/

You may need to log out of your existing Azure Account to log in with
the test account. Using an incognito mode browser window should work as
well.

**Enter the Username and password** from the email. It should be similar
to: **SCAStudent##@f5custlabs.onmicrosoft.com** where ## is your student
number.

|image19|

**Click Next.**

You should now be at the Azure Home Page. Find and **click on the
Resource Groups Icon** at the top of the screen.

|image20|

Find and **click on the Resource Group that matches the name of the
resource group you deployed in Lab 2**. It should be named RG## where ##
is your student number.

|image21|

Inside the Resource group, you should see 30 objects. Then **click on
“Deployments: 1 Succeeded”** at the top right, to validate that the
deployment was successful.

|image22|

How long did it take for the deployment to finish?

|image23|

Deployments normal take between 10 and 15 minutes depending on how busy
the cloud service provider is.

**Click on overview** to go back to the list of objects.

|image24|

Next find and **click on RGXX-ext-pip0**

|image25|

This is the external IP address used for the management plane. Please
record this for future use.

|image26|

You can copy the IP address to the clipboard by **clicking on the icon
to the right of the IP address**, do this now.

|image27|

Open your RDP application. On windows this can be done by pressing the
**Windows Key +** **R and** typing **mstsc,** then **clicking OK**

|image28|

Enter the IP address for **pip0** and **select connect**.

|image29|

**Enter the credentials from the ARM template**

Username: **xadmin**

Password: **Password11!!**

Then **click ok**

|image30|

When prompted **select the checkbox next to “Don’t ask me again for
connections to this computer”** then click **Yes.**

|image31|

Since this is the first time this windows server has been logged into
you will be bombarded with dialog boxes. Manage them thusly:

**Click yes or no**, it really does not matter, just make it go away.

|image32|

At the server manager prompt, **select the checkbox next to “Don’t show
this message again”** and **close the message box.**

|image33|

**Exit out of server manager.**

**Open internet explorer.**

**Select Use recommended settings** and **click Ok.**

|image34|

Navigate to https://192.168.1.4

**Click More information.**

**Click Go on to the webpage.**

|image35|

When prompted you will need to add websites to the trusted sites zone.

|image36|

**Enter the credentials from the ARM template**

Username: **xadmin**

Password: **Password11!!**

|image37|

Verify that you are working on the active BIG-IP. By checking the status
in the upper left-hand corner.

|image38|

If this device is not the active device log into https://192.168.1.9 and
repeat the logon process there.

**Go to Local Traffic…Virtual Servers**. How many Virtual Servers do you
see?

|image39|

Remember that the AS3 Template deployed objects into the **mgmt
partition.**

In the upper right-hand corner next to partition, **select mgmt.**

|image40|

You should now see 3 virtual servers.

|image41|

Feel free to explore some more. This is the end of Module3.

4.0 Lab Module 4 Testing Data Plane Traffic
===========================================

pip0 is intended for Management plane traffic, we have connected via
RDP, you can also connect via SSH if you have an SSH terminal and want
to test that as well.

pip1 in this exercise is intended to represent Data Plane Traffic. We
will

-  Configure the Network Security Group ACLs to allow port 80 traffic.

-  Add LB Rule for port 80 on rgXX-ext-alb to send traffic to the IPs on
   the external VLAN

-  The port 80 Virtual server (mgmt_http) will then accept he traffic
   and trigger an iRule which will send an http response.

**Log onto the Active BIG-IP**

**Go to Local Traffic…Virtual Servers**. How many Virtual Servers do you
see?

|image42|

Remember that the AS3 Template deployed objects into the **mgmt
partition.**

In the upper right-hand corner next to partition, **select mgmt.**

|image43|

You should now see 3 virtual servers.

|image44|

**Click on the mgmt_http virtual server.**

Observe that it is listening on Port 80. This support health check from
the ext-alb.

|image45|

**Select Resources…**

|image46|

Then in the iRules section **select /mgmt/mgmt_http/health_irule**

|image47|

The iRule triggers on any http request and responds with a custom http
response. In this case a simple web page that says, “System is online.”

|image48|

Try to reach this webpage over the internet.

**Go to**\ https://portal.azure.com/

You may need to log out of your existing Azure Account to log in with
the test account. Using an incognito mode browser window should work as
well.

**Enter the Username and password** from the email. It should be similar
to: **SCAStudent##@f5custlabs.onmicrosoft.com** where ## is your student
number.

|image49|

**Click Next.**

You should now be at the Azure Home Page. Find and **click on the
Resource Groups Icon** at the top of the screen.

|image50|

Find and **click on the Resource Group that matches the name of the
resource group you deployed in Lab 2**. It should be named RG## where ##
is your student number.

|image51|

Find and **click on RGXX-ext-pip1.**

|image52|

Find and **record** the IP address and DNS name of **rgXX-ext-pip1**.
Also notice that this pip is associated with **rgXX-ext-alb.**

|image53|

Open a web browser and navigate to
http://rgxx1.eastus.cloudapp.azure.com or whatever the DNS name or IP is
of pip1. This could differ if you deployed to a different region.

|image54|

Navigate back to RGXX, then find and click on

|image55|

Notice that we have 2 custom inbound ACLs to go along with the default
ones.

|image56|

**Click on Inbound Security Rules**\ …

Then **Click +Add**

Change Destination port ranges to **80**

Change name to **http_allow_80**

**Click Add**

|image57|

Navigate back to RGXX and then find and click on rgXX-ext-alb.

|image58|

Notice that we have 3 load balancing rules. We will be adding an http
rule that is identical to the RDP and SSH rules.

**Click Load balancing rules** then click **+ Add**

|image59|

For name type **http_vs**

For Frontend IP address select the **IP address corresponding to
loadbalancerFrontEnd2**. This is **pip1.**

For port choose **80.**

For Backend Port choose **80**

Leave Backend pool as **loadBalancerBackEnd**

For Health Probe choose **http_alive (HTTP:80)**

Click **ok.**

Open a web browser and navigate to
http://rgxx1.eastus.cloudapp.azure.com or whatever the DNS name or IP is
of pip1. This could differ if you deployed to a different region.

You should now see an http response.

|image60|

This is the end of Module 4!

.. |A screenshot of a cell phone Description automatically generated| image:: media/image1.png
   :width: 6.5in
   :height: 3.84514in
.. |image1| image:: media/image2.png
   :width: 2.86691in
   :height: 2.83775in
.. |image2| image:: media/image3.png
   :width: 2.81274in
   :height: 3.06693in
.. |image3| image:: media/image4.png
   :width: 2.36842in
   :height: 0.57692in
.. |image4| image:: media/image5.png
   :width: 4.14619in
   :height: 2.97526in
.. |image5| image:: media/image6.png
   :width: 6.31305in
   :height: 1.50846in
.. |image6| image:: media/image7.png
   :width: 3.26278in
   :height: 1.30428in
.. |image7| image:: media/image8.png
   :width: 2.42104in
   :height: 1.76265in
.. |image8| image:: media/image9.png
   :width: 2.85025in
   :height: 2.75441in
.. |image9| image:: media/image4.png
   :width: 2.36842in
   :height: 0.57692in
.. |image10| image:: media/image5.png
   :width: 4.14619in
   :height: 2.97526in
.. |image11| image:: media/image10.png
   :width: 4.45039in
   :height: 0.89591in
.. |image12| image:: media/image11.png
   :width: 4.49622in
   :height: 1.946in
.. |image13| image:: media/image12.png
   :width: 4.54623in
   :height: 0.54171in
.. |image14| image:: media/image13.png
   :width: 4.46705in
   :height: 0.30003in
.. |image15| image:: media/image14.png
   :width: 4.55873in
   :height: 0.30419in
.. |image16| image:: media/image15.png
   :width: 4.46705in
   :height: 0.25836in
.. |image17| image:: media/image16.png
   :width: 4.50872in
   :height: 0.25836in
.. |image18| image:: media/image17.png
   :width: 2.08351in
   :height: 1.90017in
.. |image19| image:: media/image2.png
   :width: 2.86691in
   :height: 2.83775in
.. |image20| image:: media/image18.png
   :width: 6.5in
   :height: 0.86667in
.. |image21| image:: media/image19.png
   :width: 2.78358in
   :height: 2.22936in
.. |image22| image:: media/image20.png
   :width: 6.5in
   :height: 3.95417in
.. |image23| image:: media/image21.png
   :width: 5.69216in
   :height: 1.07093in
.. |image24| image:: media/image22.png
   :width: 1.59597in
   :height: 1.51263in
.. |image25| image:: media/image23.png
   :width: 1.1751in
   :height: 0.55005in
.. |image26| image:: media/image24.png
   :width: 2.7419in
   :height: 0.97925in
.. |image27| image:: media/image25.png
   :width: 3.72532in
   :height: 0.46671in
.. |image28| image:: media/image26.png
   :width: 4.04618in
   :height: 2.30437in
.. |image29| image:: media/image27.png
   :width: 4.51706in
   :height: 2.50438in
.. |image30| image:: media/image28.png
   :width: 2.85025in
   :height: 3.12944in
.. |image31| image:: media/image29.png
   :width: 4.35038in
   :height: 3.97118in
.. |image32| image:: media/image30.png
   :width: 2.25853in
   :height: 2.50438in
.. |image33| image:: media/image31.png
   :width: 3.46697in
   :height: 1.41679in
.. |image34| image:: media/image32.png
   :width: 3.60865in
   :height: 2.47938in
.. |image35| image:: media/image33.png
   :width: 3.25028in
   :height: 3.24195in
.. |image36| image:: media/image34.png
   :width: 2.46271in
   :height: 2.2877in
.. |image37| image:: media/image35.png
   :width: 1.57514in
   :height: 2.20436in
.. |image38| image:: media/image36.png
   :width: 0.79174in
   :height: 0.42087in
.. |image39| image:: media/image37.png
   :width: 1.48763in
   :height: 0.61255in
.. |image40| image:: media/image38.png
   :width: 1.05009in
   :height: 0.25836in
.. |image41| image:: media/image39.png
   :width: 6.5in
   :height: 0.68333in
.. |image42| image:: media/image37.png
   :width: 1.48763in
   :height: 0.61255in
.. |image43| image:: media/image38.png
   :width: 1.05009in
   :height: 0.25836in
.. |image44| image:: media/image39.png
   :width: 6.5in
   :height: 0.68333in
.. |image45| image:: media/image40.png
   :width: 2.2877in
   :height: 1.68348in
.. |image46| image:: media/image41.png
   :width: 3.4503in
   :height: 0.77923in
.. |image47| image:: media/image42.png
   :width: 2.7169in
   :height: 2.65023in
.. |image48| image:: media/image43.png
   :width: 2.22936in
   :height: 1.64598in
.. |image49| image:: media/image2.png
   :width: 2.86691in
   :height: 2.83775in
.. |image50| image:: media/image18.png
   :width: 6.5in
   :height: 0.86667in
.. |image51| image:: media/image19.png
   :width: 2.78358in
   :height: 2.22936in
.. |image52| image:: media/image44.png
   :width: 1.39179in
   :height: 1.54597in
.. |image53| image:: media/image45.png
   :width: 1.98767in
   :height: 1.02509in
.. |image54| image:: media/image46.png
   :width: 6.04219in
   :height: 3.14194in
.. |image55| image:: media/image47.png
   :width: 1.50013in
   :height: 2.3627in
.. |image56| image:: media/image48.png
   :width: 6.5in
   :height: 1.83681in
.. |image57| image:: media/image49.png
   :width: 6.5in
   :height: 2.70833in
.. |image58| image:: media/image50.png
   :width: 1.17094in
   :height: 1.45429in
.. |image59| image:: media/image51.png
   :width: 5.31713in
   :height: 2.34187in
.. |image60| image:: media/image52.png
   :width: 3.0711in
   :height: 0.90841in
