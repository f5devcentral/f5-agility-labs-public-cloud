Verify Load balancing works
============================

- Open the URL provided by ``app_url`` and verify that load balancing works.
  You can go back and check the FAST template deployment exercise you did
  and check the `app_url`  


  **Note:** To find the app_url go to the /fast directory and execute terraform output

  **Note:** open a NEW webshell to run 'terraform output' in the new shell (rather than ctrl-c out of the current shell).

.. code-block:: bash

     terraform output 

.. image:: ./images/nginx-as.png
   :scale: 100%
   :alt: UDF Access


**Note:** Check Mark the Auto refresh button to see all the servers
