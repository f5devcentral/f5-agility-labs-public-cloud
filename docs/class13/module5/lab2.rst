Convert BIG-IPs to Active-Active
================================================================================

You will change the two BIG-IPs to an active-active configuration and leverage an AWS Network Load Balancer to distribute traffic to application virtual servers. This involves removing the failover group membership, but retaining the configuration sync.


Disable Network Failover (Active-Standby)
--------------------------------------------------------------------------------

#. In the Postman **Module 5 - HA via LB** folder, click on the **Prep for Active-Active BIG-IP** folder.

#. Send the **Prep-1-A [bigip1] Disable active-standby failover (make active-active)** request.

   A response status code of “200 OK” indicates that the declaration was successfully posted.

   .. image:: ./images/cfe-cleanup-device-group.png
      :align: left

   |

#. In the TMUI of each BIG-IP, verify that the BIG-IP is in the **Active** state.

#. Navigate to **Device Management > Device Groups** and verify that the current BIG-IP (self) is no longer a member of the **failoverGroup** Device Group.

   .. image:: ./images/bigip1-no-device-group.png
      :align: left

   |

   .. image:: ./images/bigip2-no-device-group.png
      :align: left
