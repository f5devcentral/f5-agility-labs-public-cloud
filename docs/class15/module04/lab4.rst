Clean your environment
=======================

- Once you have completed the tutorial, you can clean up your environment by stopping consul-terraform-sync and using ``terraform destroy`` from each of the folders you deployed from.

**Stop Consul-Terraform-Sync**


You can stop Consul-Terraform-Sync by either using CTRL+C in the shell running the daemon or by sending the SIGINT signal to the process.

Before stopping, the daemon will log the requested shutdown.

.. code-block:: bash

    ...
    [INFO] (cli) signal received to initiate graceful shutdown: terminated
    [INFO] (ctrl) stopping controller
    [INFO] (api) shutdown api server
    [INFO] (cli) graceful shutdown


**Destroy resources**

.. code-block:: bash

   $ cd ../fast


.. code-block:: bash
  
    $ terraform destroy -auto-approve

    ...
    Destroy complete! Resources: 2 destroyed.

.. code-block:: bash

    $ cd ../terraform


.. code-block:: bash

    $ terraform destroy -auto-approve

    ...
    Destroy complete! Resources: 29 destroyed.


