Clean up the lab environment
----------------------------

From the Super-NetOps terminal, clean up, then destroy the environment.

.. code-block:: bash

   lab-cleanup
   terraform destroy --force

.. attention::

   You might need to run `terraform destroy --force` a second time. Watch the console output. Nothing serious: sometimes the Internet gateways take longer to delete than the time we have configured for terraform to timeout.

.. image:: ./images/1_lab_cleanup.png
  :scale: 50%

.. image:: ./images/2_lab_cleanup.png
  :scale: 50%

.. image:: ./images/3_lab_cleanup.png
  :scale: 50%

.. image:: ./images/4_lab_cleanup.png
  :scale: 50%
