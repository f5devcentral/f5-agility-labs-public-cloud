Establish Device Trust between Big-IPs.
---------------------------------------

From ATC_Declarations click on Lab4.2-DO_HA under the drop down menu, select "do_step1.json" request.
Right Click "Post as DO Declaration".
The Status will be 202 RUNNING.

.. image:: ./images/15_do_ha.png
	   :scale: 50%

Wait a few minutes until status is 200 OK

.. image:: ./images/15_do_ha_complete.png
	   :scale: 50%

Now sign into BIG-IP Host 2. Click on Lab4.2-DO_HA under the drop down menu, select "do_step2.json" request.
Right Click "Post as DO Declaration".
The Status will be 202 RUNNING.

.. image:: ./images/15_do2_ha.png
	   :scale: 50%

Wait a few minutes until status is 200 OK

.. image:: ./images/15_do_ha_complete.png
	   :scale: 50%

TODO Change 
.. attention::

  Make sure Big-IP1 is active and Big-IP2 is standby before proceeding. To force Big-IP2 to standby: "Device Management" => "Devices" => bigip2.f5lab.dev => [Force to Standby].

From the Big-IP1 Configuration Utility (WebUI), note that bigip1.f5lab.dev is the "ONLINE (ACTIVE)" device and "In Sync".

.. image:: ./images/9_bigip1_active.png
	   :scale: 50%

From the Big-IP2 Configuration Utility (WebUI), note that bigip2.f5lab.dev is the "ONLINE (STANDBY)" device and "In Sync".

.. image:: ./images/10_bigip2_standby.png
	   :scale: 50%