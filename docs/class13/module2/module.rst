Automating BIG-IP Provisioning with Terraform
================================================================================

An advantage of deploying into public cloud environments is that the virtual network and VM instance provisioning can be fully automated.

In this module, you will:

-  Learn about the Terraform tool
-  Review the infrastructure needed to support BIG-IP VE in AWS
-  Use Terraform to deploy BIG-IPs into AWS
-  Review the configuration that is created

.. note::

   This module does not cover HA clustering/failover configuration. That will be done in a later module.

.. todo:: 

   2.1. What is Terraform?
   2.2. Lab Scenario
   2.3. Target Infrastructure End-State
   2.4. Review the Terraform Configuration Files
      2.4.1 Providers
      2.4.2 Variables
      2.4.3 Networking (VPC, NSG, Public IPs, etc)
      2.4.4 EC2 instances (BIG-IPs, app server)
      2.4.5 BIG-IP Runtime Init template
      2.4.6 Declarative Onboarding template
   2.5. Deploy the Terraform Configuration - 2 BIG-IP VE instances
   2.6. Review the Deployment in AWS Console
   2.7. Verify the BIG-IP Configuration


.. toctree::
   :caption: CONTENTS
   :maxdepth: 1
   :glob:

   lab*
