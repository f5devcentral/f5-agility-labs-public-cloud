Verify a healthy F5 environment
----------------------------------------

1. Run the handy lab-info command to quickly identify the IP addresses assigned to your environment.

.. code-block:: bash

   ./scripts/lab-info

.. code-block:: bash

   WAF ELB
     URL: https://waf-user01f5io-499431932.us-east-1.elb.amazonaws.com

   web-az1.0
     PRIVATE IP:	10.0.1.221

   web-az2.0
     PRIVATE IP:	10.0.2.221

   Big-IP2: ha-user01f5io-vpc-74c7a70d
     MGMT IP:	34.194.27.11
     VIP IP:	10.0.2.252

   BIG-IP Autoscale Instance: waf-user01f5io
     MGMT IP:	54.165.15.2

   Big-IP1: ha-user01f5io-vpc-74c7a70d
     MGMT IP:	34.230.189.240
     VIP IP:	10.0.1.37
     Elastic IP:	34.196.122.217

Sample output above. lab-info will quickly orient you around our deployment. All of the same information is available via the AWS Console, the lab-info script is here for convenience.

   - We have an application behind an F5 autoscale WAF that can be reached by the WAF ELB URL.

   - The web-az1.0 and webaz2.0 PRIVATE IP addresses will soon be configured as pool members for our Big-IP HA cluster.

   - Big-IP1 and Big-IP2 are configured as a high availability cluster across two separate availability zones. Only the active Big-IP will have an Elastic IP address assigned. Configuration changes to the active unit will automatically propagate to the standby unit. During an outage, even one affecting an entire availability zone, the Elastic IP will 'float' over to the unit that is not affected.


   - BIG-IP Autoscale Instance is a single NIC deployment WAF with the MGMT IP address identified.

2. From the f5-super-netops container test out application behind the auto-scale waf is up.

.. code-block:: bash

   curl -k https://waf-user01f5io-499431932.us-east-1.elb.amazonaws.com

Hello, World

...this is a sign that things went well and we can start configuring the Big-IPs to responsibly fulfill our part of the shared responsibility security model: https://aws.amazon.com/compliance/shared-responsibility-model/

.. image:: https://d0.awsstatic.com/security-center/NewSharedResponsibilityModel.png
