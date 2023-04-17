
#. In the Postman **Module 5 - HA via LB** folder, click on the **Prep for Active-Active BIG-IP** folder.

#. Send the **Prep-1-A [bigip1] Disable active-standby failover (make active-active)** request.

   A response status code of “200” indicates that the declaration was successfully posted.

   .. image:: ./images/cfe-cleanup-device-group.png
      :align: left

   |

#. Verify that both BIG-IPs are in the active state and not a member of the **failoverGroup** Device Group.

   .. image:: ./images/cfe-cleanup-device-group-bigip1.png
      :align: left

   |

   .. image:: ./images/cfe-cleanup-device-group-bigip2.png
      :align: left
