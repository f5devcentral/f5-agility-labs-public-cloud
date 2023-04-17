Lab Preparation - Active-Active and NLB Setup
================================================================================

Convert from Active-Standby to Active-Active
--------------------------------------------------------------------------------

#. In the Postman **Module 5 - HA via LB** folder, click on the **Prep for Active-Active BIG-IP** folder.

#. Send the **Prep-1-A [bigip1] Disable active-standby failover (make active-active)** request.

   A response status code of “200” indicates that the declaration was successfully posted.

   .. image:: ./images/cfe-cleanup-device-group.png
      :align: left

   |

#. In the TMUI of each BIG-IP, verify that the BIG-IP is in the **active** state.

#. Navigate to **Device Management > Device Groups** and verify that the current BIG-IP (self) is no longer a member of the **failoverGroup** Device Group.

   .. image:: ./images/bigip1-no-device-group.png
      :align: left

   |

   .. image:: ./images/bigip2-no-device-group.png
      :align: left


Create the NLB (Network Load Balancer) via Terraform
--------------------------------------------------------------------------------

#. In the **VS Code terminal**, enter ``copy ~/f5lab/terraform/ha-via-lb/* ~/f5lab/terraform`` to copy additional files from the **ha-via-lb** folder to the main terraform folder.

#. Enter the ``terraform init`` to download additional providers.

#. Enter ``terraform apply`` to create the NLB resource and re-deploy the AS3 declarations to the BIG-IPs.

#. In the **AWS Console**, navigate to **EC2 Dashboard > Load Balancing** to examine the new NLB resource.

   **EC2 Dashboard**

   .. image:: ./images/aws-lab-diagram-ec2-dashboard.png
      :align: left

#. In the TMUI of each BIG-IP, verify that the AS3 configurations were deployed (check the partitions).
