Configure HA cluster
================================================================================

During the initial onboarding process, the two BIG-IPs were configured as followings:

- Same Device Group
- Sync-Failover sync group
- Config sync on 'internal' interface



Configure and deploy CFE
================================================================================

.. note:: 

   Before sending the CFE declaration to the BIG-IPs, ensure that BIG-IP #1 is ACTIVE. If BIG-IP #2 is ACTIVE, then force it to STANDBY before proceeding.

On Big-IP2 make sure you are in the common partition and navigate to Device Management => Devices and select “ip-10-0-102-11.us-west-2.compute.internal.com (self)” from the list 

.. image:: ./images/cfe-force-standby-1.png
   :align: left

Scroll to the bottom of the page and click on [Force to Standby]

.. image:: ./images/cfe-force-standby-2.png
   :align: left

Once you have confirmed that BIG-IP1 is active, open Postman to send the CFE declaration to both devices.

.. image:: ./images/cfe-force-standby-3.png
   :align: left

Use Postman to send the CFE declaration to both devices
================================================================================

From Postman, under Config – Cloud Failover Extension select “Step 1-A: bigip1 - CFE - Configure cloud failover” => [Send]. 

A “200 OK” response indicates the declaration was successfully posted.

.. image:: ./images/cfe-postman-1a.png
   :align: left

From Postman, under Config – Cloud Failover Extension select “Step 1-B: bigip2 - CFE - Configure cloud failover” => [Send]. 

A “200 OK” response indicates the declaration was successfully posted.

.. image:: ./images/cfe-postman-1b.png
   :align: left

Test HA failover
================================================================================

From the Visual Studio Code Terminal, note the value of vip1_public_ip.

.. code-block:: bash

   terraform output vip1_public_ip

Open a new browser tab. Connect via HTTPS to vip1_public_ip or if you already have a tab open to the example application from a previous section, use that.

From the vscode terminal, SSH to the active BIG-IP and confirm the interfaces for the F5 Cloud Failover Extension is tracking:

.. code-block:: bash

   bigip1

.. code-block:: bash

   bash
   curl -su admin: http://localhost:8100/mgmt/shared/cloud-failover/inspect | jq .
   exit
   quit


.. image:: ./images/cfe-failover-tracking-1.png
   :align: left

From the vscode terminal, SSH to the standby BIG-IP and confirm the interfaces the F5 Cloud Failover Extension is tracking:

.. code-block:: bash

   bigip2

.. code-block:: bash

   bash
   curl -su admin: http://localhost:8100/mgmt/shared/cloud-failover/inspect | jq .
   

.. image:: ./images/cfe-failover-tracking-2.png
   :align: left

While still connected to the standby BIG-IP, perform a failover ‘dry-run’ to see what you can expect to happen during a failover event. Notice the “current” and “target” address mappings.

.. code-block:: bash

   curl -su admin: -X POST -d '{"action":"dry-run"}' http://localhost:8100/mgmt/shared/cloud-failover/trigger | jq .

.. image:: ./images/cfe-failover-dry-run.png
   :align: left

On the same standby BIG-IP, we will watch the logs before triggering a failover event.

.. code-block:: bash

   tail -f /var/log/restnoded/restnoded.log

.. image:: ./images/cfe-failover-tracking-3.png
   :align: left

From Big-IP1, Device Management => Devices => bigip1.f5lab.dev.

.. image:: ./images/cfe-failover-test-1.png
   :align: left

Force bigip1.f5lab.dev to standby. Click [Force to Standby].

.. image:: ./images/cfe-failover-test-2.png
   :align: left

On Big-IP1, in the upper-left-hand corner, note “ONLINE (STANDBY)”.

.. image:: ./images/cfe-failover-test-3.png
   :align: left

From Big-IP2, in the upper-left-hand corner, note “ONLINE (ACTIVE)”. Big-IP2 was immediately promoted to active and Big-IP1 demoted to standby.

.. image:: ./images/cfe-failover-test-4.png
   :align: left

From the AWS Console, Services => NETWORK & SECURITY => Elastic IPs. Select the Elastic IP (public IP) previously mapped to 10.0.1.51. Hit the refresh icon until you see the new mapping to 10.0.1.61 (Big-IP2).

.. image:: ./images/cfe-failover-test-5.png
   :align: left

Back to the browser tab with the example application. <CTRL-F5> a few times to refresh the browser. We are using self-signed certificates in the lab. Bypass the TLS warnings. “Accept the Risk and Continue”.

.. image:: ./images/cfe-failover-test-6.png
   :align: left

The example application reports which Availability Zone is serving up the content (pool member), not which Availability Zone is hosting the active Big-IP.

.. image:: ./images/cfe-failover-test-7.png
   :align: left

From Big-IP2, Device Management => Devices => bigip2.f5lab.dev.

Force bigip2.f5lab.dev to standby. Click [Force to Standby].

.. image:: ./images/cfe-failover-test-8.png
   :align: left

On Big-IP2, in the upper-left-hand corner, note “ONLINE (STANDBY)”.

.. image:: ./images/cfe-failover-test-9.png
   :align: left

From Big-IP1, in the upper-left-hand corner, note “ONLINE (ACTIVE)”. Big-IP1 is now back to active.

.. image:: ./images/cfe-failover-test-10.png
   :align: left

From the AWS Console, Services => NETWORK & SECURITY => Elastic IPs. Select the Elastic IP (public IP) previously mapped to 10.0.1.61. Hit the refresh icon until you see the new mapping back to 10.0.1.51 (Big-IP1).

.. image:: ./images/cfe-failover-test-11.png
   :align: left

Back to the browser tab with the example application. <CTRL-F5> a few times to refresh the browser. We are using self-signed certificates in the lab. Bypass the TLS warnings. “Accept the Risk and Continue”.

.. image:: ./images/cfe-failover-test-12.png
   :align: left
|
.. image:: ./images/cfe-failover-test-12.png
   :align: left

Remove CFE Configuration and Remove BIGIP-2 from Device Group for next Module
================================================================================

From Postman, “Lab - F5 Cloud Failover” => “Step 2-A: bigip1 - CFE - Cleanup”. => [Send]. 

A “200 OK” response indicates the declaration was successfully posted.

.. image:: ./images/cfe-cleanup-bigip1.png
   :align: left

From Postman, “Lab - F5 Cloud Failover” => “Step 2-B: bigip2 - CFE - Cleanup”. => [Send]. 

A “200 OK” response indicates the declaration was successfully posted.

.. image:: ./images/cfe-cleanup-bigip2.png
   :align: left

From Postman, “Lab - F5 Cloud Failover” => “Step 3: bigip1 - API - Cleanup”. => [Send]. 

A “200 OK” response indicates the declaration was successfully posted.

.. image:: ./images/cfe-cleanup-device-group.png
   :align: left

Verify that BIG-IP1 and BIG-IP2 are both in an Active state and not a member of the Device Group

.. image:: ./images/cfe-cleanup-device-group-bigip1.png
   :align: left
|
.. image:: ./images/cfe-cleanup-device-group-bigip2.png
   :align: left