Deploy the Terraform Configuration
================================================================================

In this section, you will customize the Terraform configuration to deploy the infrastructure in AWS.

The common Terraform deployment steps are as follows:

- terraform init
- terraform validate
- terraform plan
- terraform apply -auto-approve


.. attention::

   Before starting this section, please ensure that you have a valid BIG-IP VE license key. Your Agility Labs instructor will provide one to you.


Create a terraform.tfvars File
--------------------------------------------------------------------------------

In VSCode, click on the **terraform.tfvars.example** file. You will use this for the base variable settings of your deployment.

   .. image:: ./images/vscode-1.png
      :align: left


Save it to a new file by selecting **File->Save As...** from the menu at the top, or by presssing **<CTRL-SHIFT-S>**. Enter ``terraform.tfvars`` as the new filename.

Uncomment the **license_key** variable and enter the **BIG-IP BYOL base registration key** that was provided by your instructor.

Add your jump host's public IP address to the remote access ACL. Use a **/32** mask.

   .. note::

      The IP information was displayed in the BASH terminal when it first launched. You can view it again by launching another BASH terminal or by executing ``myip``.

Press **<CTRL-S>** to save the file.

   .. image:: ./images/vscode-2.png
      :align: left

|

Review the other variables that are defined in this file. The comments describe the purpose of each variable.

|

.. tip::

   If you prefer to use the VSCode integrated terminal instead of a separate BASH Terminal window, that will also work. Just ensure that you are in the correct directory and execute all commands as if you were using the BASH Terminal window.

   To open the integrated terminal, press <CTRL-\`> (back-tick) or select **View > Terminal** from the top menu. You will start in the **/home/f5admin** directory, so you will have to execute ``cd ~/sslo-cloud-templates/terraform-aws-sslo`` again.

|

Initialize the Terraform
--------------------------------------------------------------------------------

Before you can apply a Terraform configuration, you must |init_link| it. This will download all required Terraform module dependencies.

In your BASH Terminal, execute the following:

   .. code-block:: bash

      terraform init

You should see output similar to the following:

   .. code-block:: bash

      Initializing the backend...

      Initializing provider plugins...
      - Finding latest version of hashicorp/template...
      - Finding hashicorp/aws versions matching "~> 3.0"...
      - Finding latest version of hashicorp/tls...
      - Finding latest version of hashicorp/local...
      - Installing hashicorp/aws v3.75.2...
      - Installed hashicorp/aws v3.75.2 (signed by HashiCorp)
      - Installing hashicorp/tls v3.4.0...
      - Installed hashicorp/tls v3.4.0 (signed by HashiCorp)
      - Installing hashicorp/local v2.2.3...
      - Installed hashicorp/local v2.2.3 (signed by HashiCorp)
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

Before applying a Terraform configuration, you can |validate_link| the configuration files for syntax or consistency errors.

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

Before applying a Terraform configuration, you can review the configuration |plan_link| that would be applied. This lists the objects that would be *added*, *changed*, and/or *destroyed*.

Execute the following:

   .. code-block:: bash

      terraform plan

You should see output similar to the following:

   .. code-block:: bash

      <...>

      Plan: 61 to add, 0 to change, 0 to destroy.

      Changes to Outputs:
        + inspection_service_ip_1    = (known after apply)
        + inspection_service_ip_2    = (known after apply)
        + sslo_dmz1                  = [
            + "10.0.3.7",
            + "10.0.3.8",
          ]
        + sslo_dmz2                  = [
            + "10.0.3.244",
            + "10.0.3.245",
          ]
        + sslo_dmz3                  = [
            + "10.0.4.7",
            + "10.0.4.8",
          ]
        + sslo_dmz4                  = [
            + "10.0.4.244",
            + "10.0.4.245",
          ]
        + sslo_external              = [
            + "10.0.2.11",
            + "10.0.2.200",
          ]
        + sslo_internal              = (known after apply)
        + sslo_management            = (known after apply)
        + sslo_management_public_dns = (known after apply)
        + sslo_management_public_ip  = (known after apply)
        + sslo_vip                   = (known after apply)
        + webapp_internal            = (known after apply)

      ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

      Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if
      you run "terraform apply" now.

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

   The **-auto-approve** (or **--auto-approve**) flag allows you to bypass the approval prompt that would be received before proceeding with the configuration changes.

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
          │   with aws_instance.sslo,
          │   on vm-bigip.tf line 125, in resource "aws_instance" "sslo":
          │  125: resource "aws_instance" "sslo" {
          │
          ╵

After successful completion, you should see output similar to the following:

   .. code-block:: bash

      <...>

      Apply complete! Resources: 2 added, 4 changed, 0 destroyed.

      Outputs:

      inspection_service_ip_1 = "10.0.3.21"
      inspection_service_ip_2 = "10.0.4.21"
      sslo_dmz1 = toset([
        "10.0.3.7",
        "10.0.3.8",
      ])
      sslo_dmz2 = toset([
        "10.0.3.244",
        "10.0.3.245",
      ])
      sslo_dmz3 = toset([
        "10.0.4.7",
        "10.0.4.8",
      ])
      sslo_dmz4 = toset([
        "10.0.4.244",
        "10.0.4.245",
      ])
      sslo_external = toset([
        "10.0.2.11",
        "10.0.2.200",
      ])
      sslo_internal = "10.0.5.11"
      sslo_management = "10.0.1.11"
      sslo_management_public_dns = "ec2-x-x-x-x.compute-1.amazonaws.com"
      sslo_management_public_ip = "x.x.x.x"
      sslo_vip = "x.x.x.x"
      webapp_internal = "192.168.1.200"

|

Terraform Outputs
--------------------------------------------------------------------------------

Take note of the values for the following outputs:

- sslo_management_public_ip
- sslo_vip

You will need this information later to access the SSL Orchestrator management interface and to test the application.

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
