Test HA Failover
================================================================================

Check AS3 applications are serving the traffic
--------------------------------------------------------------------------------

#. In the **AWS Console**, nagivate to **EC2 Dashboard > Load Balancing** to validate that the NLB is working correctly. There will be only one entry. Click on it to see more details.

#. Click **target groups** at the bottom right to view the health of each BIG-IP Virtual Server. Both should show healthy.

   **Example Traffic Website with NLB**

   .. image:: ./images/aws-lab-diagram-nlb-traffic.png
      :align: left

|

Testing the failover from BIG-IP #1
--------------------------------------------------------------------------------

Disable the virtual servers on BIG-IP #1.

#. Keep the AWS console page open on the **Target Groups** page and use the refresh button to update. The health checks are set to the fastest possible and will reflect status changes in about 10-15 seconds.

#. In Postman, expand the **Failover Test > BIG-IP #1** folder.

#. Send the **NLB-1-A [bigip1] Check For Virtual Server Example01a** request.

#. Send the **NLB-2-A [bigip1] Disable Virtual Server Example01a** request to disable the application virtual server.

#. Send the **NLB-3-A [bigip1] Check For Virtual Server Example01a** request.

#. Send the **NLB-4-A [bigip1] Disable Virtual Server Example01a** request to disable the second application virtual server.

#. Return to the AWS console **Target Groups** page. One should be shown as unhealthy.

#. Browse to the NLB link using the DNS name on the **Load Balancers** page.

   The web page should still load.

   **Example NLB Traffic Group Health Status**

   .. image:: ./images/aws-lab-diagram-nlb-traffic-groups.png
      :align: left

|

Testing the failover from BIG-IP #2
--------------------------------------------------------------------------------

Disable the virtual servers on BIG-IP #2.

#. In Postman, expand the **Failover Test > BIG-IP #2** folder.

#. Send the **NLB-1-B [bigip2] Check For Virtual Server Example01a** request.

#. Send the **NLB-2-B [bigip2] Disable Virtual Server Example01a** request to disable the application virtual server.

#. Send the **NLB-3-B [bigip2] Check For Virtual Server Example01a** request.

#. Send the **NLB-4-B [bigip2] Disable Virtual Server Example01a** request to disable the second application virtual server.


#. Return to the AWS console **Target Groups** page. Now, both should be shown as unhealthy.

#. Browse to the NLB link using the DNS name on the **Load Balancers** page.

   The web page should fail to load (can take a minute or two).


Restore BIG-IP #1 applications
--------------------------------------------------------------------------------

Enable virtual servers

#. Send the **NLB-5-A [bigip1] Enable Virtual Server Example01a** request to enable the application virtual server.

#. Send the **NLB-6-A [bigip1] Enable Virtual Server Example01b** request to enable the application virtual server.

#. Return to the AWS console **Target Groups** page. One should still be shown as unhealthy.

#. Browse to the NLB link using the DNS name on the **Load Balancers** page.

   The web page should load again.


Restore BIG-IP #2 applications
--------------------------------------------------------------------------------

Enable virtual servers

#. Send the **NLB-5-B [bigip2] Enable Virtual Server Example01a** request to enable the application virtual server.

#. Send the **NLB-6-B [bigip2] Enable Virtual Server Example01b** request to enable the application virtual server.

#. Return to the AWS console **Target Groups** page. Both should be shown as healthy.

#. Browse to the NLB link using the DNS name on the **Load Balancers** page.

   The web page should continue to load.

|

This is the end of the lab module.
