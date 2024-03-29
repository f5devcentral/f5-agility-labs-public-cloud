Remove CFE configuration
================================================================================

You will now remove the CFE configuration from both BIG-IPs to prepare the environment for the next lab module.

#. In the Postman **Module 4 - Cloud Failover Extension** folder, send the **CFE-3-A [bigip1] Cleanup - Clear cloud failover configuration (prep for next module)** request.

   A response status code of **200 OK** indicates that the declaration was successfully posted.

   .. image:: ./images/cfe-postman-cleanup-3a.png
      :align: left
      :scale: 90%

   |

#. Send the **CFE-3-B [bigip2] Cleanup - Clear cloud failover configuration (prep for next module)** request.

   A response status code of **200 OK** indicates that the declaration was successfully posted.

|

This is the end of the lab module.
