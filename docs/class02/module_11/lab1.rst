Clean up the lab environment
----------------------------

.. attention::
   
   Please clean-up.
   
From Big-IQ, delete app1, app2 and userxx-ssg1.

.. image:: ./images/1_delete_apps.png
  :scale: 50%

.. image:: ./images/2_delete_ssg.png
  :scale: 50%

.. image:: ./images/3_ssg_cfg_gone.png
  :scale: 50%

In the AWS console, delete VPN Connection and Customer Gateway.

.. image:: ./images/4_delete_vpn.png
  :scale: 50%

.. image:: ./images/5_delete_customer_gw.png
  :scale: 50%

From the Super-NetOps terminal, run terraform destroy.

.. code-block:: bash

   terraform destroy --force

.. image:: ./images/6_terraform_destroy.png
  :scale: 50%

.. image:: ./images/7_terraform_destroy_done.png
  :scale: 50%

Confirm all of your instances were terminated.

.. image:: ./images/8_aws_terminated.png
  :scale: 50%

Fin.