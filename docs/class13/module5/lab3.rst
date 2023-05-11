AWS Network Load Balancer
================================================================================

You will use Terraform to create a new AWS Network Load Balancer resource and redeploy the AS3 declarations to the BIG-IPs.


Terraform Updates
--------------------------------------------------------------------------------

#. In the **VS Code** terminal, copy additional files from the **ha-via-lb** folder to the main terraform folder.

   .. code-block:: bash

      cp ~/f5lab/terraform/ha-via-lb/* ~/f5lab/terraform

   |

   .. note::

      This portion of the lab leverages the **F5 BIG-IP Terraform Provider** to deploy AS3 declarations.

   |

#. Apply the Terraform updates.

   .. code-block:: bash

      terraform apply

   |

   You should see output similar to the following:

   .. code-block:: text

      Plan: 8 to add, 1 to change, 0 to destroy.

      Do you want to perform these actions?
      Terraform will perform the actions described above.
      Only 'yes' will be accepted to approve.

      Enter a value:

   |

#. Enter ``yes`` and wait for the configuration changes to be applied.


   If the deployment fails with an error relating to the Elastic IP association, run ``terraform apply`` again.


#. In the TMUI of each BIG-IP, verify that the AS3 configurations were deployed (check the Example01 partition).

#. In the **AWS Console**, navigate to **EC2 Dashboard > Load Balancers** to examine the new NLB resource.

   .. image:: ./images/aws-lab-diagram-ec2-dashboard.png
      :align: left

   |

#. Click the load balancer resource to see more details. There will be only one load balancer.


Test Applications
--------------------------------------------------------------------------------

#. Click the **copy** icon beside the **DNS name**.

   .. image:: ./images/aws-lab-diagram-nlb-dns.png
      :align: left

   |


#. Open a new web browser tab, enter ``https://`` into the address bar, and then paste the previously copied **DNS name** value.

   You should see the example application page from one of the servers.

   .. image:: ./images/aws-lab-diagram-nlb-traffic.png
      :align: left

   |

#. In the **AWS Console**, click on the **tf-example-lb-tg** **target group** at the bottom of the **f5lab-nlb** load balancer page to view the health of each BIG-IP Virtual Server. Both should show healthy.

|
