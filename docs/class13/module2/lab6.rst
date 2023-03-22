Verify the BIG-IP (SSL Orchestrator) Configuration
================================================================================

The SSL Orchestrator's public management IP address was provided in the Terraform outputs. To show the Terraform output values again, execute ``terraform output`` in the BASH Terminal and look for **sslo_management_public_ip**.

Open a new web browser window and connect to the BIG-IP (SSL Orchestrator) TMUI: **https://<sslo_management_public_ip>**

Accept the SSL security warning.

Log in using the following credentials:

  +------------+------------+
  | Username:  | admin      |
  +------------+------------+
  | Password:  | f5Twister! |
  +------------+------------+

  |

  .. image:: ./images/bigip-login-2.png
     :align: left

|

.. attention::

   If you are unable to authenticate to the BIG-IP TMUI, then it is possible that the onboarding process has not completed yet. Wait a few minutes and try again.

   If more than 10 minutes has elapsed since attempting to log in, consult your lab instructor for additional troubleshooting help. Some part of the onboarding process may have failed (for example, due to invalid BIG-IP license key).

|

VLANs
--------------------------------------------------------------------------------

Click on **Network > VLANs** from the left panel menu and confirm that the following resources were created:

   .. image:: ./images/bigip-vlans.png
      :align: left

VLANs need to be created in advance for all the network interfaces.

Self IPs
--------------------------------------------------------------------------------

Click on **Network > Self IPs** from the left panel menu and confirm that the following resources were created:

   .. image:: ./images/bigip-selfips.png
      :align: left

Self IPs only need to be created for the transit networks: external (client-facing) and internal (server-facing). Other self IPs will be created automatically as needed by SSL Orchestrator.

Network > Routes
--------------------------------------------------------------------------------

Click on **Network > Routes** from the left panel menu and confirm that the following resources were created:

   .. image:: ./images/bigip-routes.png
      :align: left


A network route is needed for the application subnet.


Local Traffic > Pools
--------------------------------------------------------------------------------

Click on **Local Traffic > Pools** from the left panel menu and confirm that there are no pools configured.

   .. image:: ./images/bigip-pools.png
      :align: left

Later on, SSL Orchestrator will create a pool automatically for an inbound L3 Topology.

Local Traffic > Virtual Servers
--------------------------------------------------------------------------------

Click on **Local Traffic > Virtual Servers** from the left panel menu and confirm that there are no Virtual Servers configured.

   .. image:: ./images/bigip-virtuals.png
      :align: left

Later on, SSL Orchestrator will create a Virtual Server automatically for an inbound L3 Topology.

SSL Orchestrator > Configuration
--------------------------------------------------------------------------------

Click on **SSL Orchestrator > Configuration** from the left panel menu.

You will see the configuration introduction page because there is currently no configuration.

   .. image:: ./images/sslo-empty.png
      :align: left

|

This is the end of the **Automating BIG-IP (SSL Orchestrator) Provisioning with Terraform** module.
