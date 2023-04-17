Lab Scenario
================================================================================

Network Diagram
--------------------------------------------------------------------------------

Two AWS VPCs are connected to an AWS Transit Gateway, which routes traffic between the VPCs. The **app** VPC contains two application server instances (each in a different availability zone). The **hub** VPC contains two BIG-IP VE instances (each in a different availability zone).

You will configure HA failover via the F5 Cloud Failover Extension (pre-installed as part of the initial onboarding) and test a failover between BIG-IP instances.

.. image:: ./images/aws-lab-diagram-ha-cfe.png
   :align: left


Pre-existing BIG-IP Cluster Configuration
--------------------------------------------------------------------------------

During the initial onboarding process, the two BIG-IPs were configured as follows:

- Same Device Group (Sync-Failover)
- Config sync on 'internal' interface
- Network Failover on 'internal' interface
