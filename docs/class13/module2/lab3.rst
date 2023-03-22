Review the Terraform Configuration Files
================================================================================

The GitHub repository that you cloned in a previous step contains a directory called **terraform-aws-sslo**. You will now review the Terraform configuration files to understand what they do.


Terraform Directory
--------------------------------------------------------------------------------
In the BASH terminal, change to the Terraform directory.

   .. code-block:: bash

      cd ~/sslo-cloud-templates/terraform-aws-sslo
      ls

You should see several Terraform (\*.tf) files listed.

   .. code-block:: bash

      README.md        f5_onboard.tmpl  routetable.tf      terraform.tfvars.example  vm-bigip.tf     vm-webapp.tf
      ansible_vars.tf  main.tf          securitygroups.tf  transitgateway.tf         vm-inspect1.tf  vpc.tf
      aws-keypair.tf   outputs.tf       subnets.tf         variables.tf              vm-inspect2.tf

Review these files with **Visual Studio Code (VSCode)** by executing the following:

   .. code-block:: bash

      code .

   *'code' + <space> + <dot>*

Wait for VSCode to launch and display the file list in the left panel.

.. tip::

   If the font is too small or too large, you can adjust the size by pressing **<CTRL-+>** (control-plus) or **<CTRL-->** (control-minus).

|

Click on each file that corresponds to the sections below. VSCode provides Terraform syntax highlighting when the **HashiCorp Terraform extension** is installed.

|

Terraform Providers
--------------------------------------------------------------------------------

Providers enable configuration of resources available from a service provider.

.. list-table:: **Providers**
   :header-rows: 1
   :widths: auto

   * - Filename
     - Description
   * - main.tf
     - Defines the AWS Terraform Provider dependency.


Terraform Variables
--------------------------------------------------------------------------------

Variables allow you to create flexible and scalable Terraform deployments by eliminating hardcoded values in each configuration file.

.. list-table:: **Terraform Variables**
   :header-rows: 1
   :widths: auto

   * - Filename
     - Description
   * - variables.tf
     - Defines all Terraform variables (and some default values) used in the other configuration files.
   * - terraform.tfvars.example
     - Examples of explicitly configured Terraform variable values.

       This is a template for your own **terraform.tfvars** file, which will set values for the variables defined in the **variables.tf** file.


Virtual Network
--------------------------------------------------------------------------------

Network objects types are defined in separate Terraform configuration files.

.. list-table:: **Virtual Network Deployment**
   :header-rows: 1
   :widths: auto

   * - Filename
     - Description
   * - vpc.tf
     - Creates the **Security** and **Application** VPCs.
   * - subnets.tf
     - Creates the subnets in the **Security** and **Application** VPCs.
   * - routetable.tf
     - Creates the Internet Gateway and custom route tables needed to steer traffic through the inspection devices.

       An **Internet Gateway** is needed to provide external access to resources within the VPCs.

       **Route Tables** are needed to steer traffic to specific gateways. They are applied to the **"TO Service"** (dmz1 and dmz3) and **"FROM Service"** (dmz2 and dmz4) subnets of the L3 inspection devices. This ensures the proper traffic flows through the inspection devices.

   * - transitgateway.tf
     - Creates the **Transit Gateway** to route between the **Security** and **Application** VPCs. This simplifies the peering of VPCS.
   * - securitygroups.tf
     - Creates the network Security Groups that control access to/from the VPC Subnets.

       A Security Group protects the BIG-IP public management IP - allowing only connections from your jump host's public IP address.


EC2 Instances
--------------------------------------------------------------------------------

Each EC2 VM instance is defined in a separate Terraform configuration file.

.. list-table:: **EC2 VM Deployment**
   :header-rows: 1
   :widths: auto

   * - Filename
     - Description
   * - vm-webapp.tf
     - Deploys the **Wordpress** demo application server in the **Application** VPC.

       Creates 1 **Network interface** (application subnet).

       This application will be protected by SSL Orchestrator (when configured by Ansible in a later lab module).
   * - vm-inspect1.tf
     - Deploys a **Snort (Intrusion Detection and Prevention System)** instance as an L3 inspection device in the **Security** VPC.

       Creates 3 **Network interfaces**  (management, TO Service, and FROM Service subnets). The instance routes traffic between its TO Service and FROM Service interfaces.

   * - vm-inspect2.tf
     - Deploys a second **Snort (Intrusion Detection and Prevention System)** instance as an L3 inspection device in the **Security** VPC.

       Creates 3 **Network interfaces**  (management, TO Service, and FROM Service subnets). The instance routes traffic between its TO Service and FROM Service interfaces.

       To simplify this lab, both inspection devices use the same AWS image. Each Snort instance routes traffic between its TO Service and FROM Service interfaces.
   * - vm-bigip.tf
     - Deploys a BIG-IP (SSL Orchestrator) VE instance in the **Security** VPC.

       Creates 7 **Network interfaces** (management, external, internal, dmz1, dmz2, dmz3, and dmz4 subnets), public IPs, and F5 onboarding configuration.

       Elastic IP addresses (EIPs) / public IPs are created and associated to a NIC to provide inbound access to EC2 instances. The BIG-IP VE will have the following EIPs assigned to provide remote administration access, as well as access to the application Virtual Server IP:

       - Public Management IP -> Private BIG-IP Management IP
       - Public Application Virtual Server IP -> Private BIG-IP Application Virtual Server IP

       Access to the BIG-IP public Management IP is protected by a network Security Group that contains your jump host public IP address.


F5 Automation
--------------------------------------------------------------------------------

The base system settings and network configuration are provisioned using **F5 Automation Toolchain** extensions.

.. list-table:: **F5 Onboarding Template**
   :header-rows: 1
   :widths: auto

   * - Filename
     - Description
   * - f5_onboard.tmpl
     - Terraform template for rendering **BIG-IP Runtime Init** and **Declarative Onboarding** configuration data.

       The BIG-IP VM that is created in the **vm-bigip.tf** configuration file references the cloud-init data that is rendered by this template.

       See the following links for more details:

       - |runtime-init_link|
       - |do_link|


Terraform Outputs
--------------------------------------------------------------------------------

.. list-table:: **Terraform Outputs**
   :header-rows: 1
   :widths: auto

   * - Filename
     - Description
   * - outputs.tf
     - Defines the values to be **output**. Some values are dynamically generated, so need to be output for use later in the lab.


Miscellaneous
--------------------------------------------------------------------------------
Additional Terraform files are provided to support this lab.

.. list-table:: **Miscellaneous Configuration**
   :header-rows: 1
   :widths: auto

   * - Filename
     - Description
   * - aws-keypair.tf
     - Creates an AWS SSH keypair to be used for authentication to EC2 VM instances.
   * - ansible_vars.tf
     - Creates the Ansible Variables file that will be used in a later lab module.


.. |runtime-init_link| raw:: html

      <a href="https://github.com/F5Networks/f5-bigip-runtime-init" target="_blank"> f5-bigip-runtime-init </a>

.. |do_link| raw:: html

      <a href="https://clouddocs.f5.com/products/extensions/f5-declarative-onboarding/latest/" target="_blank"> f5-declarative-onboarding </a>
