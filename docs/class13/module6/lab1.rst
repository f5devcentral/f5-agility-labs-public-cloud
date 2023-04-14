Lab Scenario
================================================================================

Two AWS VPCs are connected to an AWS Transit Gateway, which routes traffic between the VPCs. The **app** VPC contains two application server instances (each in a different availability zone). The **hub** VPC contains two BIG-IP VE instances (each in a different availability zone).

Each student will configure **F5 Telemetry Streaming** to send System log data to AWS Cloudwatch, then view the logs via the AWS Console. Connectivity from BIG-IP1 and BIG-IP2 to CloudWatch will use the Internal Vlan.


**Network Diagram**

.. image:: ./images/2023_ts-lab-diagram.png
   :align: left
