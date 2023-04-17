Deploy CFE Configuration
================================================================================

Check Active-Standby Status
--------------------------------------------------------------------------------

.. important::

   Before sending the CFE declaration to the BIG-IPs, ensure that **BIG-IP #1** is **ACTIVE**. If BIG-IP #2 is ACTIVE, then force it to STANDBY before proceeding.

|

#. On **BIG-IP #2**, ensure that you are working with the **Common** partition.

#. Navigate to **Device Management > Devices** and select **ip-10-0-102-11.us-west-2.compute.internal.com (self)** from the list.

   .. image:: ./images/cfe-fix-active-standby-1.png
      :align: left

#. Scroll to the bottom of the page and click on [Force to Standby]

   .. image:: ./images/cfe-fix-active-standby-2.png
      :align: left

#. Once you have confirmed that BIG-IP1 is active, open Postman to send the CFE declaration to both devices.

   .. image:: ./images/cfe-fix-active-standby-3.png
      :align: left

|

Send the CFE Declaration to Both Devices
--------------------------------------------------------------------------------

#. In the Postman **Module 4 - Cloud Failover Extension** folder, send the **CFE-2-A [bigip1] Configure cloud failover** request.

   A response status code of “200” indicates that the declaration was successfully posted.

   .. image:: ./images/cfe-postman-config-2a.png
      :align: left

#. The CFE declaration must also be sent to **BIG-IP #2**. Send the **CFE-2-B [bigip2] Configure cloud failover** request.

   A response status code of “200” indicates that the declaration was successfully posted.

   .. image:: ./images/cfe-postman-config-2b.png
      :align: left
