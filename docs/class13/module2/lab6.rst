Verify the BIG-IP Configurations
================================================================================

Each BIG-IP's public management IP address was provided in the Terraform outputs. To show the Terraform output values again, execute ``terraform output`` in the BASH terminal and look for the **bigip1_mgmt_public_ip** and **bigip2_mgmt_public_ip** outputs.

   .. code-block:: bash

      bigip1_mgmt_public_ip = "a.b.c.d"
      bigip2_mgmt_public_ip = "e.f.g.h"
      bigip1_password = "xxxxxxxxxxxxxxxx"
      bigip2_password = "xxxxxxxxxxxxxxxx"
      random_password = "xxxxxxxxxxxxxxxx"

Also note the values of **bigip1_password** and **bigip2_password**. They should be the same as **random_password**.

Open a new web browser tab and connect to the first BIG-IP's TMUI: https:// *<bigip1_mgmt_public_ip>*

Accept the SSL security warning.

Log in using the following credentials:

  +------------+----------------------+
  | Username:  | admin                |
  +------------+----------------------+
  | Password:  | *<random_password>*  |
  +------------+----------------------+

  |

  .. image:: ./images/bigip-login.png
     :align: left

|

.. attention::

   If you are unable to authenticate to the BIG-IP TMUI, then it is possible that the onboarding process has not completed yet. Wait a few minutes and try again.

   If more than 10 minutes has elapsed since attempting to log in, consult your lab instructor for additional troubleshooting help. Some part of the onboarding process may have failed.

|

F5 Automation Toolchain Extensions
--------------------------------------------------------------------------------

Click on **iApps > Package Management LX** from the left panel menu. You will see the list of iControl LX packages that were installed by BIG-IP Runtime Init.

   .. image:: ./images/ilx_pkg.png
      :align: left

|

VLANs
--------------------------------------------------------------------------------

Click on **Network > VLANs** from the left panel menu and confirm that the following resources were created:

   .. image:: ./images/bigip-vlans.png
      :align: left

The ATC DO declaration configured the **external** and **internal** VLANs.

|

Self IPs
--------------------------------------------------------------------------------

Click on **Network > Self IPs** from the left panel menu and confirm that the following resources were created:

   .. image:: ./images/bigip-selfips.png
      :align: left

The ATC DO declaration configured self IPs on the **external** and **internal** VLANs.

|

Network > Routes
--------------------------------------------------------------------------------

Click on **Network > Routes** from the left panel menu and confirm that the following resources were created:

   .. image:: ./images/bigip-routes.png
      :align: left


The ATC DO declaration configured two routes:

- The **default** route is via the **external** VLAN.
- The **app-route** static route enables access to the **app** VPC.

|

Local Traffic > Virtual Servers
--------------------------------------------------------------------------------

Click on **Local Traffic > Virtual Servers** from the left panel menu and confirm that there are no Virtual Servers configured.

   .. image:: ./images/bigip-virtuals.png
      :align: left

|

BIG-IP #2
--------------------------------------------------------------------------------

Open a new web browser window and connect to the TMUI: https:// *<bigip2_mgmt_public_ip>*.

Review the configuration settings:

- **iApps > Package Management LX**
- **Network > VLANs**
- **Network > Self IPs**
- **Network > Routes**
- **Local Traffic > Virtual Servers**
