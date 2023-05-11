Lab Scenario
================================================================================

Network Diagram
--------------------------------------------------------------------------------

Two AWS VPCs are connected to an AWS Transit Gateway, which routes traffic between the VPCs. The **app** VPC contains two application server instances (each in a different availability zone). The **hub** VPC contains two BIG-IP VE instances (each in a different availability zone).

Only one of the BIG-IP instances and the two application servers are needed in this lab module.


.. image:: ./images/as3-lab-diagram.png
   :alt: Lab diagram
   :align: left
   :width: 100%

|

Infrastructure Target State
--------------------------------------------------------------------------------

You will deploy AS3 configurations for the following:

- Two HTTP applications using AWS autodiscovery
- Two HTTPS applications configured to use HTTP/2
- Update the two HTTPS applications to use ECDSA certificates

You will also examine an application configuration from BIG-IP qkview snapshot, and then convert it into an AS3 declaration.
