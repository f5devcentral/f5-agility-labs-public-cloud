Check status of F5 instances before proceeding.
-----------------------------------------------

From the AWS Web Console => Services => EC2 => INSTANCES => Instances. Select "Big-IP1...". Select the "Status Check" tab below.

.. image:: ./images/1_aws_console_bigip1_status_check.png
	   :scale: 50%

From the AWS Web Console => Services => EC2 => INSTANCES => Instances. Select "Big-IP2...". Select the "Status Check" tab below.

.. image:: ./images/2_aws_console_bigip2_status_check.png
	   :scale: 50%

.. attention::

  Do not proceed until both the System Status Checks and Instance Status Checks for both Big-IP1 and Big-IP2 announce **...reachability check passed** in green!

SSH to Big-IP1 and Big-IP2
--------------------------

Confirm the bigip1 and bigip2 aliases were created.

.. code-block:: bash

   type bigip1
   type bigip2

SSH to Big-IP1 to confirm state and change the admin password.

.. attention::

   Ensure the system status prompt is either Active or Standby before proceeding. All other status prompts indicate the system is not ready. Use the screenshots as a guide.

.. code-block:: bash

   bigip1

Acknowledge the ssh remote host when prompted "Are you sure you want to continue connecting (yes/no)?"

.. code-block:: bash

   yes
   modify auth user admin password f5letme1n
   modify /sys global-settings gui-setup disabled
   save /sys config
   quit

SSH to Big-IP2 to confirm state and change the admin password.

.. attention::

   Ensure the system status is either Active or Standby before proceeding. All other status prompts indicate the system is not ready. Use the screenshots as a guide.

.. code-block:: bash

   bigip2

Acknowledge the ssh remote host when prompted "Are you sure you want to continue connecting (yes/no)?"

.. code-block:: bash

   yes
   modify auth user admin password f5letme1n
   modify /sys global-settings gui-setup disabled
   save /sys config
   quit

.. image:: ./images/3_bigip_modify_auth.png
	   :scale: 50%

Configuration Utility (WebUI) HTTPS access to Big-IP1 and Big-IP2
-----------------------------------------------------------------

From the Visual Studio Code Terminal, invoke `Terraform output`. Note the Bigip1ManagementEipAddress and Bigip2ManagementEipAddress values.

.. code-block:: bash

   terraform output

.. image:: ./images/4_terraform_output.png
	   :scale: 50%

Open a new browser tab and HTTPS to Bigip1ManagementEipAddress. We are using self-signed certificates in the lab. Bypass the TLS warnings. "Accept the Risk and Continue".

.. image:: ./images/5_bigip1_mgmt_ip.png
	   :scale: 50%

.. image:: ./images/6_bigip1_mgmt_bypass_warning.png
	   :scale: 50%

Login to the Big-IP1 Configuration Utility (WebUI):

  Username: admin

  Password: f5letme1n

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
