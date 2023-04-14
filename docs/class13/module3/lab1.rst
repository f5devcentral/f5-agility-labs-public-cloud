Lab Scenario
================================================================================

Two AWS VPCs are connected to an AWS Transit Gateway, which routes traffic between the VPCs. The **app** VPC contains two application server instances (each in a different availability zone). The **hub** VPC contains two BIG-IP VE instances (each in a different availability zone).

Only one of the BIG-IP instances and the two application servers are needed in this lab module.


Infrastructure Target State
================================================================================

The AS3 configuration that you will use in this lab module deploys the following:

- Two HTTP applications using AWS autodiscovery
- Two HTTPS applications configured to use HTTP/2
- Update the two HTTPS applications to use ECDSA certificates
- Examine a Qkview and convert one application into an AS3 declaration


.. note::

   This module does not cover HA clustering/failover configuration. That will be done in a later module.


**Network Diagram**

.. image:: ./images/as3-lab-diagram.png
   :alt: Lab diagram
   :align: left
   :width: 100%

