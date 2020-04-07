Delete the configuration objects you manually created
-----------------------------------------------------

Delete the TCP iApp that created the Virtual Servers.

iApps => Application Services => Applications. Select *example01* and delete. Delete again to confirm.

.. attention::

  Alternatively, follow the steps below to delete the configuration objects manually.

From Big-IP1, Local Traffic => Virtual Servers => Select both Virtual Servers and [Delete].

.. image:: ./images/1_delete_virtual_servers.png
	   :scale: 50%

From Big-IP1, Local Traffic => Pools => Select "service_discovery_pool" and [Delete].

.. image:: ./images/2_delete_pool.png
	   :scale: 50%

From Local Traffic => Nodes => Node List => Select both nodes and [Delete].

.. image:: ./images/3_delete_node.png
	   :scale: 50%


Prepare Postman
---------------

From the Visual Studio Code Terminal, copy the postman_rendered.json file to the desktop. This file contains the environment variables for a Postman collection.

.. code-block:: bash

   cp ./postman_rendered.json /mnt/c/Users/Administrator/Desktop/

.. image:: ./images/4_copy_postman_rendered_to_desktop.png
	   :scale: 50%

The postman_rendered.json file was copied to the Windows desktop.

.. image:: ./images/5_postman_rendered_desktop.png
	   :scale: 50%

Open Postman. Click the wrench icon in the upper-right-hand corner to review Settings. Ensure that "SSL certificate verification" is turned "OFF". Close Settings.

.. image:: ./images/6_postman_ssl_cert_verification_off.png
	   :scale: 50%

Click "Import" in the upper-left-hand corner. Choose "Import From Link". Import the Postman Collection for this lab from:

.. code-block:: bash

   https://raw.githubusercontent.com/TonyMarfil/f5agility2020-pc101/master/postman/f5agility2020-pc101-postman-collection.json

.. image:: ./images/7_postman_import_collection_from_link.png
	   :scale: 50%

.. image:: ./images/8_postman_collection_imported.png
	   :scale: 50%

Confirm the **F5 Agility 2020 PC101 Lab** Collection has been imported.

In the upper-right-hand corner. To the far right of the "No Environment" drop-down menu. Click the gear icon and "Import from File".
Navigate to \\This PC\\Desktop\\postman_rendered.json => [Open].

.. image:: ./images/9_import_environment_from_desktop.png
	   :scale: 50%

Confirm the environment was successfully imported. Choose "Agility 2020 - Use Terraform to..." from the Environment drop-down menu in the upper-right-hand corner.

.. image:: ./images/10_postman_select_imported_environment.png
	   :scale: 50%

Install the Application Services 3 Extension
--------------------------------------------

Big-IP1 => iApps => Package ManagementLX => [Browse] => This PC\\Downloads\\iControl_LX\\f5-appsvcs... Upload the f5-appsvc... package.

Do the same for Big-IP2.

.. image:: ./images/11_bigip_upgrade_as3.png
	   :scale: 50%

From Postman, click on the environment view icon immediately to the right of the "Agility 2020 - Use Terraform..." environment. You can see here that the environment variables have been prepared for the lab.

.. image:: ./images/12_postman_review_environment_variables.png
	   :scale: 50%

Create virtual servers and enable modern protocols such as TLS 1.3 and HTTPS/2 with AS3
---------------------------------------------------------------------------------------

From Postman, select "Step 1: Check AS3 - BIGIP1" request.
Click "Send".
The Status is 200 OK and the Body response will indicate the AS3 version.

.. image:: ./images/13_postman_confirm_as3_bigip1.png
	   :scale: 50%

From Postman, select "Step 3: Create AS3 - Example01/example01 with AutoDiscover pool..." request.
Click "Send".

.. image:: ./images/14_postman_review_as3_declaration_body.png
	   :scale: 50%

Change the HTTP method from POST to GET and click "Send". You can do this often to track the status of the AS3 declaration in the Response. Status 202 indicates the declaration was successfully submitted and is being processed, Status 200 indicates the declaration has successfully completed.

.. image:: ./images/15_postman_review_as3_send3.png
	   :scale: 50%

.. image:: ./images/16_postman_as3_202.png
	   :scale: 50%

Eventually, the status will be 200 OK. Our AS3 declaration has successfully created virtual servers and services.

.. image:: ./images/17_postman_as3_200.png
	   :scale: 50%

On Big-IP1, choose the new Example01 partition in the upper-right hand corner.

.. image:: ./images/18_bigip1_example01_partition.png
	   :scale: 50%

Big-IP1 => Local Traffic => Virtual Servers. Review the newly created example01a and example01b HTTP virtual servers.

.. image:: ./images/19_bigip1_example01_virtual_servers.png
	   :scale: 50%

Big-IP1 => Local Traffic => Pools. Review the newly created pool1.

.. image:: ./images/20_bigip1_example01_pool_autodiscover.png
	   :scale: 50%

From the browser, connect to the example application over HTTP.

.. image:: ./images/21_bigip1_example01_example_app.png
	   :scale: 50%

This application is running over unencrypted HTTP/1.1. Let's turn on modern protocols TLS 1.2 (HTTPS) and HTTP/2.

In Postman, Select the "Step 4: Create AS3 - Example01/example01 HA Modern Protocols" request. Click [Send]

.. image:: ./images/22_postman_as3_modern_protocols1_200.png
	   :scale: 50%

Big-IP1 **Example01 Partition** => Local Traffic => Virtual Servers. Review the virtual servers created.

.. image:: ./images/23_bigip1_example01_virtual_servers_modern_protocols1.png
	   :scale: 50%

In Postman, Select the "Step 5: Create AS3 - Example01/example01 HA Modern Protocols" request. Click [Send]

.. image:: ./images/24_postman_as3_modern_protocols2_200.png
	   :scale: 50%

From the browser, connect to the example application over HTTPS. We are using self-signed certificates in the lab. Bypass the TLS warnings. "Accept the Risk and Continue".

.. attention::

   Preface the IP address with https://

Hover over the lightning bolt icon in the upper-right hand corner and note "HTTP/2 is active for the top-level document" 

.. image:: ./images/25_bigip1_example01_example_app_https_http2.png
	   :scale: 50%

In Postman, Select the "Step 6: Create AS3 - Example01/example01 ECDSA Cert" request. Click [Send]

.. image:: ./images/26_postman_as3_modern_protocols_ecdsa_200.png
	   :scale: 50%

From the browser, connect to the example application over https. We are using self-signed certificates in the lab. Bypass the TLS warnings. "Accept the Risk and Continue".

.. image:: ./images/27_bigip1_example01_example_app_ecdsa_bypass_warning.png
	   :scale: 50%

From the browser explore the ciphers used.

.. image:: ./images/28_bigip1_example01_example_app_ecdsa_tls1.2.png
	   :scale: 50%
