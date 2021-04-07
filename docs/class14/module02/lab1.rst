Configuration Utility (WebUI) HTTPS access to Big-IP1 and Big-IP2
------------------------------------------------------------

From the terraform outputs, take the link for bigip_X_mgmtIP and open the WebUI for each BIG-IP.  From the VS Code terminal, you can type "terraform output" to see the outputs again.

Open a new browser tab and HTTPS to Bigip1ManagementEipAddress. We are using self-signed certificates in the lab. Bypass the TLS warnings. "Accept the Risk and Continue".

.. image:: ./images/5_bigip1_mgmt_ip.png
	   :scale: 50%

.. image:: ./images/6_bigip1_mgmt_bypass_warning.png
	   :scale: 50%

Login to the Big-IP1 Configuration Utility (WebUI) using the values found in "terraform output"

...note the system has not been configured with anything other than a management IP address and admin account.

No self-IP.

.. image:: ./images/8_bigip_no_config1.png
	   :scale: 50%

No Routes.

.. image:: ./images/9_bigip_no_config2.png
	   :scale: 50%

Traffic interface in uninitialized state.

.. image:: ./images/10_bigip_no_config3.png
	   :scale: 50%

No Virtual Servers.

.. image:: ./images/11_bigip_no_config4.png
	   :scale: 50%

No Device Groups.

.. image:: ./images/12_bigip_no_config5.png
	   :scale: 50%

Do the same for Big-IP2.

.. image:: ./images/7_bigip2_mgmt_bypass_warning.png
	   :scale: 50%










