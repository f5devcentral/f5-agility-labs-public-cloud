Lab Scenario
================================================================================

Network Diagram
--------------------------------------------------------------------------------

Two AWS VPCs are connected by an AWS Transit Gateway, which routes traffic between the VPCs. The **app** VPC contains two application server instances (each in a different availability zone). The **hub** VPC contains two BIG-IP VE instances (each in a different availability zone). Users must connect to a Virtual Server on a BIG-IP to access the application.

.. image:: ./images/aws-lab-diagram.png
   :align: left

|


Infrastructure Target State
--------------------------------------------------------------------------------

The Terraform configuration that you will use in this lab module deploys the following:

- AWS networking resources (2 VPCs, subnets, transit gateway, internet gateway, NAT gateway, route tables, security groups, etc)
- Application server instances (2 Linux VMs)
- BIG-IP VE instances (2 VMs) with F5 Automation Toolchain extensions (DO, AS3, TS, CFE)
- BIG-IP base networking (VLANs, IP addresses, routes)

.. note::

   This module does not cover HA clustering/failover configuration. That will be done in a later module.

|


Virtual Lab Infrastructure Details (and Credentials)
--------------------------------------------------------------------------------

The following tables provide device network configuration details. Login credentials are also provided for use as directed in the lab exercises.

.. list-table:: **BIG-IP VE Instances**
   :header-rows: 0
   :widths: 300 700 700

   
   * - Instance
     - **BIG-IP #1**
     - **BIG-IP #2**

   * - **Availability Zone**
     - AZ-1
     - AZ-2

   * - **Management IP**
     - Primary: 10.0.101.11/24 + Associated Elastic IP (Public) address
     - Primary: 10.0.102.11/24 + Associated Elastic IP (Public) address

   * - **External Subnet**
     - Primary: 10.0.1.11/24

       Secondary: 10.0.1.12, 10.0.1.101, 10.0.1.102, 10.0.1.103, 10.0.1.104
     - Primary: 10.0.2.11/24

       Secondary: 10.0.2.12, 10.0.2.101, 10.0.2.102, 10.0.2.103, 10.0.2.104

   * - **Internal Subnet**
     - Primary: 10.0.10.11/24
     - Primary: 10.0.20.11/24

   * - **Default Route**
     - 10.0.1.1 (external subnet)
     - 10.0.2.1 (external subnet)

   * - **Static Route**
     - 10.1.0.0/16 (app-vpc) via 10.0.10.1 (internal subnet)
     - 10.1.0.0/16 (app-vpc) via 10.0.20.1 (internal subnet)

   * - **TMUI Login**
     - Username: admin

       Password: <<randomly-generated>

       Check Terraform outputs for password.

     - Username: admin

       Password: <randomly-generated>

       Check Terraform outputs for password.

   * - **SSH Login**
     - Username: admin

       Password: <ssh-key>

       The **root** account is disabled.

     - Username: admin

       Password: <ssh-key>

       The **root** account is disabled.

   * - **System DNS**
     - 169.254.169.253 (AWS DNS)
     - 169.254.169.253 (AWS DNS)

|

.. list-table:: **Application Server Instances**
   :header-rows: 0
   :widths: 300 700 700

   * -
     - **App Server #1**
     - **App Server #2**

   * - **Availability Zone**
     - AZ-1
     - AZ-2

   * - **IP Address**
     - Primary: 10.1.200.80/24
     - Primary: 10.1.201.80/24

   * - **Default Route**
     - 10.1.200.1 (app subnet)
     - 10.1.201.1 (app subnet)
   
   * - **SSH Login**
     - Username: ec2-user

       Password: <ssh-key>

     - Username: ec2-user

       Password: <ssh-key>

   * - **System DNS**
     - 169.254.169.253 (AWS DNS)
     - 169.254.169.253 (AWS DNS)

|

.. list-table:: **Windows Jump Host (win2019)**
   :header-rows: 0
   :widths: 300 500

   * - RDP Login
     - Username: user
  
       Password: user


.. warning::
   Simple passwords may be used in this lab environment in order to make it easier for students to access the infrastructure. The jump host in this lab environment is only accessible by you after successfully authenticating to the UDF portal.

   If deploying in your own lab, please follow recommended security practices by using strong passwords and restricting network access.
