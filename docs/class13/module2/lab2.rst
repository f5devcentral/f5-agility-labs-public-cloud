Lab Scenario
================================================================================

.. _scenario:

Two AWS VPCs are connected by an AWS Transit Gateway, which routes traffic between the VPCs. The **application** VPC contains two application server instances (each in a different availability zone). The **hub** VPC contains two BIG-IP VE instances (each in a different availability zone). Users will connect to a Virtual Server on the BIG-IP(s) to access the application.


.. image:: ./images/aws-lab-diagram.png
   :align: left


Target Infrastructure End-State
================================================================================

The Terraform configuration that you will use in this lab module deploys the following:

- AWS networking resources
- Application server instances
- BIG-IP VE instances

**Network Diagram (placeholder)**

.. image:: ./images/labinfo-new.png
   :align: left

The BIG-IP VE interfaces are configured as follows:

.. list-table:: **Interface Descriptions**
   :header-rows: 1
   :widths: auto

   * - Interface
     - Description
   * - MGMT
     - Dedicated out-of-band management interface
   * - 1.1
     - Connected to the Internet-facing subnet
   * - 1.2
     - Connected to the application-facing subnet

.. todo:: 

   more editing



Virtual Lab Infrastructure Details (and Credentials)
--------------------------------------------------------------------------------

The following tables provide device/service network configuration details. Login credentials are also provided for use as directed in the lab exercises.

.. list-table:: **BIG-IP #1**
   :header-rows: 0
   :widths: auto

   * - BIG-IP Management IP
     - 10.0.1.11 - Associated Public IP address is provided in Terraform outputs

   * - Login
     - Username: admin

       Password: f5Twister!

       The **root** account is disabled.

   * - System DNS
     - 169.254.169.253 (AWS DNS)

   
.. list-table:: **Windows Jump Host (win2019)**
   :header-rows: 0
   :widths: 200 300

   * - Login
     - Username: user

       Password: user


.. warning::
   Simple passwords were used in this lab environment in order to make it easier for students to access the infrastructure. The jump host in this lab environment is only accessible to you after successfully authenticating to the UDF portal.

   If deploying in your own lab, please follow recommended security practices of using strong passwords and restricting network access.
