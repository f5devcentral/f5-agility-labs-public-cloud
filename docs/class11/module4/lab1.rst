Check status of F5 instances before proceeding.
-----------------------------------------------

From the AWS Web Console => Services => EC2 => INSTANCES => Instances. Select the Big-IP1... Select the "Status Check" tab below.

.. image:: ./images/1_aws_console_ec2_bigip_status_check.png
  :scale: 50%

From the AWS Web Console => Services => EC2 => INSTANCES => Instances. Select the Big-IP2... Select the "Status Check" tab below.

.. image:: ./images/2_aws_console_ec2_bigip_status_check2.png
  :scale: 50%

.. attention::

   Ensure both the System Status Checks and the Instance Status Checks have passed (green font) before proceeding.

Create terraform data resource to read CloudFormation outputs.
--------------------------------------------------------------

From the Visual Studio Code Terminal, enable the f5-cft-outputs.tf terraform file.

.. code-block:: bash

   mv f5-cft-outputs.tf.zzz f5-cft-outputs.tf

.. image:: ./images/3_vscode_mv_f5_cft_outputs_zzz_to_tf.png
  :scale: 50%

`terraform init`

.. code-block:: bash

    terraform init

`terraform validate`

.. code-block:: bash

   terraform validate

.. image:: ./images/5_vscode_terraform_validate.png
  :scale: 50%

`terraform plan`

.. code-block:: bash

   terraform plan -var 'bigip_admin_password=f5letme1n'

.. image:: ./images/6_vscode_terraform_plan.png
  :scale: 50%

`terraform apply`

.. code-block:: bash

   terraform apply -var 'bigip_admin_password=f5letme1n' -auto-approve

.. image:: ./images/7_vscode_terraform_apply.png
  :scale: 50%

`terraform` apply completed.

.. image:: ./images/8_vscode_terraform_apply_complete.png
  :scale: 50%

SSH to Big-IP1 and Big-IP2
--------------------------
Run the `create-ssh-to-bigip-alias.sh` shell script to create convenient command aliases for `bigip1` and `bigip2`.

.. code-block:: bash

   source create-ssh-to-bigip-alias.sh

.. image:: ./images/9_create_ssh_to_bigip_alias.png
  :scale: 50%

Confirm the bigip1 and bigip2 aliases were created.

.. code-block:: bash

   type bigip1
   type bigip2

.. image:: ./images/10_type_bigip_alias.png
  :scale: 50%

SSH to Big-IP1 to confirm state and change the admin password.

.. attention::

   Ensure the system status prompt is either Active or Standby before proceeding. All other status prompts indicate the system is not ready. Use the screenshots as a guide.

.. code-block:: bash

   bigip1
   modify auth user admin password f5letme1n
   modify /sys global-settings gui-setup disabled
   save /sys config
   quit

Acknowledge the ssh remote host when prompted "Are you sure you want to continue connecting (yes/no)?" **yes**
   
.. image:: ./images/11_bigip1_confirm_state.png
  :scale: 50%

.. image:: ./images/12_bigip1_modify_auth.png
  :scale: 50%

SSH to Big-IP2 to confirm state and change the admin password.

.. attention::

   Ensure the system status is either Active or Standby before proceeding. All other status prompts indicate the system is not ready. Use the screenshots as a guide.

.. code-block:: bash

   bigip2
   modify auth user admin password f5letme1n
   modify /sys global-settings gui-setup disabled
   save /sys config
   quit

Acknowledge the ssh remote host when prompted "Are you sure you want to continue connecting (yes/no)?" **yes**

.. image:: ./images/13_bigip2_modify_auth.png
  :scale: 50%

Configuration Utility (WebUI) HTTPS access to Big-IP1 and Big-IP2
-----------------------------------------------------------------
We need the management address to connect to the Configuration utility (WebUI). Invoke `terraform output` and look for:

  Bigip1Url
  
  Bigip2Url

.. code-block:: bash

   terraform output

.. image:: ./images/14_terraform_output_cft.png
  :scale: 50%

From the Visual Studio Code Terminal, Ctrl + click to follow link for **"BigIP1Url" =** 

.. image:: ./images/16_bigip1_url.png
  :scale: 50%

We are using self-signed certificates in the lab. Bypass the TLS warnings. "Accept the Risk and Continue".

.. image:: ./images/17_bigip1_bypass_tls_warning.png
  :scale: 50%

Login to the Big-IP1 Configuration Utility (WebUI):

  Username: admin

  Password: f5letme1n

.. image:: ./images/18_bigip1_login.png
  :scale: 50%

Look in the upper-left-hand corner. Note whether this is the active or standby unit.

.. image:: ./images/18a_bigip1_login_active.png
  :scale: 50%

From the Visual Studio Code Terminal, Ctrl + click to follow link for **"BigIP2Url" =** 

.. image:: ./images/19_bigip2_url.png
  :scale: 50%

We are using self-signed certificates in the lab. Bypass the TLS warnings. "Accept the Risk and Continue".

.. image:: ./images/20_bigip2_bypass_tls_warning.png
  :scale: 50%

Login to the Big-IP2 Configuration Utility (WebUI):

  Username: admin
  
  Password: f5letme1n

.. image:: ./images/21_bigip2_login.png
  :scale: 50%

Look in the upper-left-hand corner. Note whether this is the active or standby unit.

.. image:: ./images/21a_bigip2_login_active.png
  :scale: 50%