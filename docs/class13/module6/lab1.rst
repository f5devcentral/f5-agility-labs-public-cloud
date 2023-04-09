Lab Scenario
================================================================================
Two AWS VPCs are connected to an AWS Transit Gateway, which routes traffic between the VPCs. The **app** VPC contains two application server instances (each in a different availability zone). The **hub** VPC contains two BIG-IP VE instances (each in a different availability zone).

You will configure F5 Telemetry Streaming to send System and Application log data to AWS Cloudwatch, then view the logs via the AWS Console.


**Diagram**

.. image:: ./images/ts-lab-diagram.png
   :align: left
