AWS Network Load Balancer
================================================================================

You will use Terraform to create a new AWS Network Load Balancer resource and redeploy the AS3 declarations to the BIG-IPs.


Terraform Updates
--------------------------------------------------------------------------------

#. In the **VS Code terminal**, copy additional files from the **ha-via-lb** folder to the main terraform folder.

   .. code-block:: bash

      cp ~/f5lab/terraform/ha-via-lb/* ~/f5lab/terraform

   |

#. Enter re-initialize Terraform to download additional providers.

   .. code-block:: bash

      terraform init


   |

   .. note::

      This portion of the lab leverages the **F5 BIG-IP Terraform Provider** to deploy AS3 declarations.

   |

#. Apply the Terraform updates.

   .. code-block:: bash

      terraform apply -auto-approve


   |

#. In the **AWS Console**, navigate to **EC2 Dashboard > Load Balancers** to examine the new NLB resource.

   **EC2 Dashboard**

   .. image:: ./images/aws-lab-diagram-ec2-dashboard.png
      :align: left

   |

#. In the TMUI of each BIG-IP, verify that the AS3 configurations were deployed (check the partitions).
