Deploy CFE Configuration
================================================================================

Check Active-Standby Status
--------------------------------------------------------------------------------

|

.. important::

   Before configuring CFE on the BIG-IPs, you must first ensure that **BIG-IP #1** is **Active**.

   At this point in the lab, **BIG-IP #2** is **Active**, so you will have to force it to **Standby**.

|

#. On **BIG-IP #2**, ensure that you are working with the **Common** partition.


#. Navigate to **Device Management > Devices** and select **ip-10-0-102-11.us-west-2.compute.internal.com (self)** from the list.

   .. image:: ./images/cfe-fix-active-standby-1.png
      :align: left
      :scale: 50%



#. Scroll to the bottom of the page and click on the **Force to Standby** button.

   .. image:: ./images/cfe-fix-active-standby-2.png
      :align: left
      :scale: 50%


#. On **BIG-IP #1**, confirm that it is now **ACTIVE**.

   .. image:: ./images/cfe-fix-active-standby-3.png
      :align: left
      :scale: 50%

|


Send the CFE Declaration to Both Devices
--------------------------------------------------------------------------------

#. In the Postman **Module 4 - Cloud Failover Extension** folder, send the **CFE-2-A [bigip1] Configure cloud failover** request.

   A response status code of “200 OK” indicates that the declaration was successfully posted.

   .. image:: ./images/cfe-postman-config-2a.png
      :align: left
      :scale: 50%


#. The CFE declaration must also be sent to **BIG-IP #2**. Send the **CFE-2-B [bigip2] Configure cloud failover** request.

   A response status code of “200 OK” indicates that the declaration was successfully posted.

   .. image:: ./images/cfe-postman-config-2b.png
      :align: left
      :scale: 50%
