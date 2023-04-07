Deploy the Terraform Configuration
================================================================================

In this section, you will customize the Terraform configuration to deploy the infrastructure in AWS.

Then, you will step through a common Terraform deployment flow as follows:

- terraform init
- terraform validate
- terraform plan
- terraform apply


Create a terraform.tfvars File
--------------------------------------------------------------------------------

Variables allow you to easily customize the deployment settings, instead of editing values in multiple Terraform files.

A **terraform.tfvars** file is commonly used to define variable values used in the Terraform deployment.
These values override any default values that may be defined in the **variables.tf** file.
You will use the included sample **tfvars** file for the base settings of your deployment.

In VS Code, click on the **terraform** directory, and then the **terraform.tfvars.example** file.

   .. image:: ./images/vscode-1.png
      :align: left


|

Save it to a new file by selecting **File->Save As...** from the menu at the top, or by presssing **<CTRL-SHIFT-S>**. Enter ``terraform.tfvars`` as the new filename.

   .. image:: ./images/vscode-2.png
      :align: left

|

Review the other variables that are defined in this file. They define the important attribute values required for the AWS deployment.

You may (optional) update the ``emailid`` variable with your e-mail address.

Press **<CTRL-S>** to save the file.


.. attention::

   Please do not change anything else in this file. The configuration is specific to the operation of this lab environment and related documentation.

|

Initialize the Terraform
--------------------------------------------------------------------------------

Before you can apply a Terraform configuration, you must |init_link| it. This will download all required Terraform module dependencies.

Switch back to the other VS Code window (with the BASH terminal) and execute the following:

   .. code-block:: bash

      terraform init

You should see output similar to the following:

   .. code-block:: bash

      Initializing the backend...

      Initializing provider plugins...
      - Finding latest version of hashicorp/null...
      - Finding latest version of hashicorp/random...
      - Finding latest version of hashicorp/tls...
      - Finding latest version of hashicorp/http...
      - Finding hashicorp/local versions matching "~> 1.2"...
      - Finding hashicorp/template versions matching "~> 2.1"...
      - Finding latest version of hashicorp/aws...
      - Installing hashicorp/aws v4.61.0...
      - Installed hashicorp/aws v4.61.0 (signed by HashiCorp)
      - Installing hashicorp/null v3.2.1...
      - Installed hashicorp/null v3.2.1 (signed by HashiCorp)
      - Installing hashicorp/random v3.4.3...
      - Installed hashicorp/random v3.4.3 (signed by HashiCorp)
      - Installing hashicorp/tls v4.0.4...
      - Installed hashicorp/tls v4.0.4 (signed by HashiCorp)
      - Installing hashicorp/http v3.2.1...
      - Installed hashicorp/http v3.2.1 (signed by HashiCorp)
      - Installing hashicorp/local v1.4.0...
      - Installed hashicorp/local v1.4.0 (signed by HashiCorp)
      - Installing hashicorp/template v2.2.0...
      - Installed hashicorp/template v2.2.0 (signed by HashiCorp)

      Terraform has created a lock file .terraform.lock.hcl to record the provider
      selections it made above. Include this file in your version control repository
      so that Terraform can guarantee to make the same selections by default when
      you run "terraform init" in the future.

      Terraform has been successfully initialized!

      You may now begin working with Terraform. Try running "terraform plan" to see
      any changes that are required for your infrastructure. All Terraform commands
      should now work.

      If you ever set or change modules or backend configuration for Terraform,
      rerun this command to reinitialize your working directory. If you forget, other
      commands will detect it and remind you to do so if necessary.

|

.. attention::

   Do not proceed if this process fails. There may be an error in one (or more) of the Terraform configuration files which will require further investigation.

|

Validate the Terraform
--------------------------------------------------------------------------------

Before applying a Terraform configuration, you can |validate_link| the configuration files for syntax or consistency errors. This will not test remote resources.

Execute the following:

   .. code-block:: bash

      terraform validate

You should see output similar to the following:

   .. code-block:: bash

      Success! The configuration is valid.

|

.. attention::

   Do not proceed if this process fails. There may be an error in one (or more) of the Terraform configuration files which will require further investigation.

|

Review the Terraform Plan
--------------------------------------------------------------------------------

Before applying a Terraform configuration, you can review the configuration |plan_link| that would be applied. This will also test remote resources. A list of the objects that would be *added*, *changed*, and/or *destroyed* will be displayed.

Execute the following:

   .. code-block:: bash

      terraform plan

You should see output similar to the following:

   .. code-block:: bash

      <...>

      Plan: 62 to add, 0 to change, 0 to destroy.

      Changes to Outputs:

      <...>

      ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

      Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take
      exactly these actions if you run "terraform apply" now.

|

.. attention::

   Do not proceed if this process fails. There may be an error in one (or more) of the Terraform configuration files which will require further investigation.

|

Apply the Terraform Plan
--------------------------------------------------------------------------------

To |apply_link| the Terraform configuration, execute the following:

   .. code-block:: bash

      terraform apply -auto-approve

This will take several minutes to complete.

.. note::

   The **-auto-approve** (or double-dash **--auto-approve**) flag allows you to bypass the approval prompt that would be received before proceeding with the configuration changes.

|

.. attention::

   If you receive an error similar to the following (for any of the EC2 instances), wait about 5 minutes and then try to ``apply`` again. It might require multiple attempts due to timing.

      .. code-block:: bash

          ╷
          │ Error: Error launching source instance: PendingVerification: Your request
          │ for accessing resources in this region is being validated, and you will
          │ not be able to launch additional resources in this region until the
          │ validation is complete. We will notify you by email once your request has
          │ been validated. While normally resolved within minutes, please allow up to 4
          │ hours for this process to complete. If the issue still persists, please let
          │ us know by writing to aws-verification@amazon.com for further assistance.
          │       status code: 400, request id: a3fd2a74-1451-4c8a-a56a-901df30875d4
          │


After successful completion, you should see output similar to the following:

   .. code-block:: bash

      <...>

      Apply complete! Resources: 62 added, 0 changed, 0 destroyed.

      Outputs:

      <...>

|

Terraform Outputs
--------------------------------------------------------------------------------

The Terraform outputs include the following:

.. list-table:: **Terraform Outputs (EXAMPLES)**
   :header-rows: 1
   :widths: auto

   * - Key
     - Value
   * - AWS_CONSOLE_LINK
     - "https://xxxxxxxxxxxx.signin.aws.amazon.com/console"
   * - AWS_PASSWORD
     - "xY&+66d6vt|18Wz{@NbM2(WQ"
   * - AWS_USER
     - "udf"
   * - appsvr1_private_address
     - 10.1.200.80
   * - appsvr2_private_address
     - 10.1.201.80
   * - bigip1_mgmt_public_ip
     - 52.34.106.47
   * - bigip1_password
     - ttwOrFT1lwsCEMP1
   * - bigip1_private_external_address
     - 10.0.1.11/24
   * - bigip1_private_internal_address
     - 10.0.10.11/24
   * - bigip1_private_mgmt_address
     - 10.0.101.11/24
   * - bigip1_username
     - admin
   * - bigip2_mgmt_public_ip
     - 52.10.70.80
   * - bigip2_password
     - ttwOrFT1lwsCEMP1
   * - bigip2_private_external_address
     - 10.0.2.11/24
   * - bigip2_private_internal_address
     - 10.0.20.11/24
   * - bigip2_private_mgmt_address
     - 10.0.102.11/24
   * - bigip2_username
     - admin
   * - f5_ami_id
     - ami-07b879247e4b415ff
   * - f5_ami_name
     - F5 BIGIP-17.1.0-0.0.16 PAYG-Adv WAF Plus 25Mbps-230222034728-3c272b55-0405-4478-a772-d0402ccf13f9
   * - jumphost_ip
     - 52.27.102.168
   * - linux_ami_id
     - ami-099e00fe4091e48af
   * - linux_ami_name
     - amzn2-ami-minimal-hvm-2.0.20230320.0-x86_64-ebs
   * - random_password
     - ttwOrFT1lwsCEMP1
   * - vip1_public_ip
     - 44.224.128.190

|

In the future, if you want to show the Terraform |output_link| values again, you can execute the following:

   .. code-block:: bash

      terraform output



.. |init_link| raw:: html

      <a href="https://www.terraform.io/cli/commands/init" target="_blank"> initialize </a>

.. |validate_link| raw:: html

      <a href="https://www.terraform.io/cli/commands/validate" target="_blank"> validate </a>

.. |plan_link| raw:: html

      <a href="https://www.terraform.io/cli/commands/plan" target="_blank"> plan </a>

.. |apply_link| raw:: html

      <a href="https://www.terraform.io/cli/commands/apply" target="_blank"> apply </a>

.. |output_link| raw:: html

      <a href="https://www.terraform.io/cli/commands/output" target="_blank"> output </a>
