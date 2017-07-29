Configuration Utility (Web UI) access
-------------------------------------

1. Use the lab-info script to identify the management IP address of each of the three BigIP instances that we created. By defaultt, F5 cloud instances are locked down to ssh key access only. Let's create an admin password so we can login via the configuration utility (web ui). 

.. code-block:: bash

   ./scripts/lab-info

...look for three instances of MGMT IP.

2. Use the reset-password script create an admin password. Perforrm this task for all three of the MGMT IP's. Replace the example IP address in the example below with the MGMT IP addresses specific to your lab.

.. code-block:: bash

   ./scripts/reset-password 52.207.200.169

...your console output should look like the screeshot below.

.. image:: ./images/reset-password.png
  :scale: 50%