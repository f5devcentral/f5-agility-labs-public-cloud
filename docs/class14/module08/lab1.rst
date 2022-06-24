Using AS3 to create services
============================

Since your devices are now clustered in a sync-failover group and using
auto-sync, you can post service declarations to whichever device you choose.
A change to one BIG-IP will be automatically be replicated to the other.

In the previous modules you validated that there were no virtual
servers on the BIG-IPs.  You can validate this again, but up until this point
we have not modified the BIG-IPs to have any virtual servers.

Post AS3 declarations
---------------------

Click on Lab4.3-AS3 under the drop down menu, select "as3.json" request.
Right Click "Post as AS3 Declaration".

.. image:: ./images/Lab4.5-AS3-BIGIP1PostasAS3.png
   :scale: 60%
   :alt: Post as AS3 

Status code 200 response signals that Application Services 3 Extension (AS3) is
completed on Big-IP1.

.. image:: ./images/Lab4.5-AS3-BIGIP1PostasAS3_Success.png
   :scale: 60%
   :alt: Post as AS3 Success

AS3 and Service Discovery
--------------------------

As part of AS3, you can now leverage service discovery to automatically parse
the cloud environment to look for Metadata.  In Google Cloud this is done via labels on
instances, or items like forwarding rules.  Review the Body of the declaration.
The AS3 declaration is configured to discover pool members based on Google Cloud labels.

Log into Big-IP1 => Local Traffic => Virtual Servers. Choose the "Example01"
Partition from the Drop-down in the upper-right-hand corner. AS3 created two
HTTP virtual servers: example01a and example01b.

.. image:: ./images/Lab4.5-AS3-BIGIP1_VS_TMUI.png
   :scale: 60%
   :alt: Virtual server list Active Device

Now within Big-IP1 => Local Traffic => Pools. Note "pool1". AS3 used Google Cloud tags
to discover and auto-populate pool1 with two web servers.

.. image:: ./images/Lab4.5-AS3-BIGIP1_PoolMembers_TMUI.png
   :scale: 60%
   :alt: Pool member list - Service Discovery

Log into Big-IP2 => Local Traffic => Virtual Servers. Choose the "Example01"
Partition from the Drop-down in the upper-right-hand corner. Even though you
only POSTED an AS3 declaration to Big-IP1, Config Sync replicated the Virtual
Servers and all supporting configuration objects (pools, profiles, etc.) to
Big-IP2.

.. image:: ./images/Lab4.5-AS3-BIGIP2_VS_TMUI.png
   :scale: 75%
   :alt: Virtual server list Standby Device

View the websites you created
-----------------------------

In your terminal pane, CTL+Click on the webapp_external_IP link, twice.  

.. image:: ./images/Lab4.5-AS3-ClickExternalIP.png
   :scale: 100%
   :alt: terraform output link

.. image:: ./images/Lab4.5-AS3-ExternalIP_http.png
   :scale: 60%
   :alt: web app on port 80

In the second tab, add the port of the second service, 6514 to the web address.

.. image:: ./images/Lab4.5-AS3-ExternalIP_http6514.png
   :scale: 60%
   :alt: Web app port 6514

Verify which BIG-IP is receiving the traffic
--------------------------------------------

On each BIG-IP, navigate the the statistics page for the virtual servers. 
Verify that you are in the partition that the AS3 declara
Local Traffic --> Virtual Servers --> Statistics tab --> seleect Virtual Servers 

.. image:: ./images/Lab4.5-AS3-TMUI_VS_statLink.png
   :scale: 60%
   :alt: Virtual server statistics link

.. image:: ./images/Lab4.5-AS3-TMUI_VS_statPage.png
   :scale: 60%
   :alt: Virtual server statistics page

.. image:: ./images/Lab4.5-AS3-TMUI_VS_statPage_2.png
   :scale: 60%
   :alt: Virtual server statistics page


Now on both BIG-IPs, set the statistics to auto refresh every 10 seconds.

Fail over traffic from BIG-IP1 to BIG-IP2 and refresh the web app tabs 5-10 times.

Observe the statistics and how the numbers follow the active device.







