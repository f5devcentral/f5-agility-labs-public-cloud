Review the Terraform Configuration Files
================================================================================

You will now review the Terraform configuration files to understand what they do.


Terraform Directory
--------------------------------------------------------------------------------

The **terraform** directory contains all of the configuration files needed to deploy the lab environment in AWS.

#. In the VS Code terminal, list the Terraform directory.

   .. code-block:: bash

      ls terraform

   You should see several Terraform (\*.tf) files listed. The various components of the lab are deployed via separate configuration files to make it easier to manage.

   .. code-block:: bash

      ami-search.tf  bigip1.tf            cloudwatch.tf        main.tf              templates                 vpc-app.tf
      appserver1.tf  bigip2.tf            credentials.tf       nat-gateway.tf       terraform.tfvars.example  vpc-hub.tf
      appserver2.tf  certs.tf             internet-gateway.tf  postman-env-file.tf  transit-gateway.tf
      bigip-vips.tf  cfe-dependencies.tf  jumphost-ip.tf       securitygroups.tf    variables.tf


View Terraform Files
--------------------------------------------------------------------------------

#. Review these files with VS Code by executing the following:

   .. code-block:: bash

      code .

   *'code' + <space> + <dot>*

   Wait for VS Code to launch a new window and display the project directory in the left panel.

   |

   .. tip::

      If the font is too small or too large, you can adjust the size by pressing **<CTRL-+>** (control-plus) or **<CTRL-->** (control-minus).


   |

#. Click on the **terraform** directory to expand it.

#. Click on each file that corresponds to the sections below. VS Code provides Terraform syntax highlighting when the **HashiCorp Terraform extension** is installed.


Terraform Providers
--------------------------------------------------------------------------------

Providers enable configuration of dependencies for resource providers (e.g., minimum version for AWS, Azure).

.. list-table:: **Providers**
   :header-rows: 1
   :widths: auto

   * - Filename
     - Description
   * - main.tf
     - Defines the AWS Terraform Provider dependency.

|

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

       This is a template for your own **terraform.tfvars** file, which will set (or override) values for the variables defined in the **variables.tf** file.

|

Virtual Network
--------------------------------------------------------------------------------

Network objects types are defined in separate Terraform configuration files.

.. list-table:: **Virtual Network Deployment**
   :header-rows: 1
   :widths: auto

   * - Filename
     - Description
   * - vpc-hub.tf
     - Creates the **hub** VPC, subnets, and route tables (to Internet and app VPC).
   * - vpc-app.tf
     - Creates the **app** VPC, subnets, and route tables.
   * - transitgateway.tf
     - Creates the **Transit Gateway** to route traffic between the **hub** and **app** VPCs. This simplifies the peering of VPCs.
   * - internet-gateway.tf
     - Creates the Internet Gateway. A route table in the vpc-hub.tf file defines a default route to the Internet Gateway.

       An **Internet Gateway** provides external access to resources within the VPCs.
   * - nat-gateway.tf
     - Creates the NAT Gateway for outbound Internet access from the application subnet. This is  needed for the app servers to perform their onboarding. A route table in the vpc-hub.tf file is associated with the 'internal' subnet to send app server outbound traffic to the Internet Gateway.

   * - securitygroups.tf
     - Creates the network Security Groups that control access to/from the VPC Subnets.

       A Security Group protects the BIG-IP public management IP - allowing only connections from your jump host's public IP address.

   * - bigip-vips.tf
     - Creates an Elastic IP address (EIP) / public IP and associates it to a private BIG-IP Virtual IP Address. This allows Internet clients to reach a BIG-IP Virtual Server.

.. note::

   Access to lab Public IPs is restricted by a Security Group that contains your jump host public IP address.

|

EC2 Instances
--------------------------------------------------------------------------------

Each EC2 VE instance is defined in a separate Terraform file.

.. list-table:: **EC2 VM Deployment**
   :header-rows: 1
   :widths: auto

   * - Filename
     - Description
   * - appserver1.tf
     - Deploys a demo application server instance in AZ1 of the **app** VPC.

       Creates a **Network interface** (app_az1 subnet).

   * - appserver2.tf
     - Deploys a demo application server instance in AZ2 of the **app** VPC.

       Creates a **Network interface** (app_az2 subnet).

   * - bigip1.tf
     - Deploys a BIG-IP VE instance in AZ1 of the **hub** VPC.

       Creates the following:

       - 3 **Network interfaces** (hub_bigip1_mgmt, hub_bigip1_external, hub_bigip1_internal)
       - An EIP / public IP that is associated with the BIG-IP's private management self IP to provide remote administration access).
       - F5 onboarding configuration (BIG-IP Runtime Init and F5 Automation Toolchain extensions)

   * - bigip2.tf
     - Deploys a BIG-IP VE instance in AZ2 of the **hub** VPC.

       Creates the following:

       - 3 **Network interfaces** (hub_bigip1_mgmt, hub_bigip1_external, hub_bigip1_internal)
       - An EIP / public IP that is associated with the BIG-IP's private management self IP to provide remote administration access.
       - F5 onboarding configuration (BIG-IP Runtime Init and F5 Automation Toolchain extensions)

.. note::

   Access to the lab BIG-IP Management Public IPs is restricted by a Security Group that contains your jump host public IP address.

|

F5 Automation
--------------------------------------------------------------------------------

The base system settings and network configuration are provisioned using **F5 Automation Toolchain** extensions.

.. list-table:: **F5 Onboarding Template**
   :header-rows: 1
   :widths: auto

   * - Filename
     - Description
   * - templates/f5_onboard_3nic_custom.tmpl
     - Template for rendering **BIG-IP Runtime Init** and **Declarative Onboarding** configuration data.
       A cloud-init script is created that will:

       - Install and executes the BIG-IP Runtime Init onboarding tool
       - Install F5 Automation Toolchain extension packages for DO, AS3, CFE, and TS
       - Deploy a DO declaration to configure the base system settings (glboal settings, admin user/password, SSH key, resource provisioning, etc) and network settings (3 interfaces, VLANs, self IPs, routes)

       The **bigip1.tf** and **bigip2.tf** files reference this template to generate their onboarding configuration file.

       See the following links for more details:

       - |runtime-init_link|
       - |do_link|

|

Miscellaneous
--------------------------------------------------------------------------------
Additional Terraform files are included to support this lab.

.. list-table:: **Miscellaneous Configuration**
   :header-rows: 1
   :widths: auto

   * - Filename
     - Description
   * - credentials.tf
     - Creates an AWS Key Pair for SSH access to BIG-IPs and Linux app servers. Also creates a random 16-character password for the BIG-IP admin user account (used for BIG-IP GUI access).
   * - jumphost-ip.tf
     - Determines the jump host's public IP address. Referenced by the security groups that restrict access to the lab Public IPs.
   * - ami-search.tf
     - Creates Terraform data sources containing the Amazon Machine Image (AMI) IDs for the BIG-IP VE and Linux app server EC2 instances. They are filtered based on the **f5_ami_search_name** and **linux_ami_search_name** variables. The most recent image version is selected When multiple AMI IDs are returned.
   * - certs.tf
     - Creates ECDSA certificates for the lab environment.
   * - as3declaration-file.tf
     - Creates the an AS3 declaration file with ECDSA certificates. This is used with the **F5 VS Code Extension** in Module 3.
   * - f5extension-importdevices-file.tf
     - Creates a JSON file containing the BIG-IP public management IP addresses. This is used with the **F5 VS Code Extension** in Module 3.
   * - cfe-dependencies.tf
     - Creates an S3 Bucket and IAM policy for use with the Cloud Failover Extension.
   * - cloudwatch.tf
     - Creates Amazon CloudWatch resources for analytics integration.
   * - postman-env-file.tf
     - Creates a Postman environment variables file based on Terraform variables and dynamic data.
   * - templates/f5lab_postman_env_template.json
     - Template for the Postman environment variables file that is generated by postman-env-file.tf.

|

Terraform Outputs
--------------------------------------------------------------------------------

Output values are included in some of the Terraform files (rather than consolidated in a separate outputs.tf file).
The outputs are covered in the next section.


.. |runtime-init_link| raw:: html

      <a href="https://github.com/F5Networks/f5-bigip-runtime-init" target="_blank"> f5-bigip-runtime-init </a>

.. |do_link| raw:: html

      <a href="https://clouddocs.f5.com/products/extensions/f5-declarative-onboarding/latest/" target="_blank"> f5-declarative-onboarding </a>
