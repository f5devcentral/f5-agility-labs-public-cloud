Configuration Utility (Web UI) access
-------------------------------------

1. Use the lab-info script to identify the management IP address of each of the three BigIP instances that we created. By default, F5 cloud instances are locked down to ssh key access only. Let's create an admin password so we can login via the configuration utility (web ui). 

.. code-block:: bash

   lab-info

...look for three instances of MGMT IP and make absolutely sure that **"STATUS:      MCPD is up, System Ready"**

.. attention::

   Before creating an admin password on your Big-IPs you must be certain that cloud-init has finished the Big-IP onboarding process. Wait until **"STATUS:      MCPD is up, System Ready"**.

.. attention::

   Before creating an admin password on your Big-IPs check that your shortUrl still exists as an environment variable:

   .. code-block:: bash

      echo $shortUrl

   ...if it does not, you will have to export again. For example, if the shortUrl=abc123 then:

   .. code-block:: bash

      export shortUrl=abc123   


2. Use the reset-password script to create an admin password. Perforrm this task for all three of the MGMT IP's. Replace the example IP address in the example below with the MGMT IP addresses specific to your lab.

.. code-block:: bash

   reset-password 52.207.200.169

...your console output should look like the screeshot below.

.. image:: ./images/reset-password.png
  :scale: 50%