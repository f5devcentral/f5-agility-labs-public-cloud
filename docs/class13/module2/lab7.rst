Prepare Postman
================================================================================

From the Visual Studio Code Terminal, copy the postman_rendered.json file to the desktop. This file contains the environment variables for a Postman collection.

.. code-block:: bash

   cp ./postman_rendered.json /mnt/c/Users/user/Desktop/

.. image:: ./images/1_postman_rendered.png
	   :scale: 50%


The postman_rendered.json file was copied to the Windows desktop.

.. image:: ./images/2_postman_rendered_desktop.png
	   :scale: 50%


Open Postman. Click the gear icon in the upper-right-hand corner to review Settings. Ensure that "SSL certificate verification" is turned "OFF". Close Settings.

.. image:: ./images/6_postman_ssl_cert_verification_off.png
	   :scale: 50%


In the left-pane tab, select "Collections" and click "Import" above. Choose "Link" as the source to import from and Import the collection using the URL below:

.. code-block:: bash

   https://raw.githubusercontent.com/tmarfil/f5agility2022-pc201/master/postman/f5agility2022-pc201-postman-collection.json
.. image:: ./images/3_postman_import_collection.png
	   :scale: 50%


Confirm the **F5 Agility 2021 PC201 Lab** Collection has been imported.

.. image:: ./images/4_postman_collection_imported.png
	   :scale: 50%


In the left-pane tab, sellect "Environments" and click "Import" above. Choose "File" as the source to import from and navigate to **This PC\\Desktop\\postman_rendered.json** and click "Open".

.. image:: ./images/5_postman_import_environment.png
	   :scale: 50%


Click on "Import" to import the environment.

.. image:: ./images/5_postman_environment_imported.png
	   :scale: 50%


Confirm the environment was successfully imported by selecting the "**Agility 2020 - Use Terraform to...**" environment from the Environment drop-down menu in the upper-right-hand corner.

.. image:: ./images/00_postman_environment_check.png
	   :scale: 50%
