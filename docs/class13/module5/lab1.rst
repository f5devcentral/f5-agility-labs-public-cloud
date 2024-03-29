Lab Scenario
================================================================================

You will configure HA failover via an AWS Network Load Balancer and test a failover between BIG-IP instances.

Network Diagram
--------------------------------------------------------------------------------

Two AWS VPCs are connected to an AWS Transit Gateway, which routes traffic between the VPCs. The **app** VPC contains two application server instances (each in a different availability zone). The **hub** VPC contains two BIG-IP VE instances (each in a different availability zone).


.. image:: ./images/aws-lab-diagram-ha-lb.png
   :align: left


Pre-existing BIG-IP Cluster Configuration
--------------------------------------------------------------------------------

During the initial onboarding process, the two BIG-IPs were configured as follows:

- Sync-Failover Device Group (active-standby)
- Config sync on 'internal' interface
- Network Failover on 'internal' interface
