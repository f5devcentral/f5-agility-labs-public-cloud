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


Active-Active BIG-IP VE Instances via AWS NLB
--------------------------------------------------------------------------------

You will change the setup of the two BIG-IPs to an active-active configuration and leverage an AWS Network Load Balancer (NLB) to distribute traffic to application virtual servers. This involves removing the failover group membership, retaining the configuration sync, creating the NLB (via Terraform) and re-creating the AS3 applications (via Terraform).

Summary of lab steps:
   - Create the NLB.
   - Break the network failover config between the BIG-IPs.
   - Test the NLB by stopping virtual servers on the BIG-IPs to simulate failure events.
   - Validate the NLB activity via the AWS console.

