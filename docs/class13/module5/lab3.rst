AWS Network Load Balancer
================================================================================

You will use Terraform to create a new AWS Network Load Balancer resource and redeploy the AS3 declarations to the BIG-IPs.


Terraform Updates
--------------------------------------------------------------------------------

#. In the **VS Code terminal**, enter ``copy ~/f5lab/terraform/ha-via-lb/* ~/f5lab/terraform`` to copy additional files from the **ha-via-lb** folder to the main terraform folder.

#. Enter ``terraform init`` to download additional providers.

   .. note::

      This portion of the lab leverages the **F5 BIG-IP Terraform Provider** to deploy AS3 declarations.

   |

#. Enter ``terraform apply -auto-approve`` to deploy the updates.

#. In the **AWS Console**, navigate to **EC2 Dashboard > Load Balancers** to examine the new NLB resource.

   **EC2 Dashboard**

   .. image:: ./images/aws-lab-diagram-ec2-dashboard.png
      :align: left

#. In the TMUI of each BIG-IP, verify that the AS3 configurations were deployed (check the partitions).
