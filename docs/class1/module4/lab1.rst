Verify a healthy F5 environment
-------------------------------

1. Run the handy lab-info command to quickly identify the IP addresses assigned to your environment.

.. code-block:: bash

   lab-info

.. code-block:: bash

   AWS Console
    URL: https://f5agility2017.signin.aws.amazon.com/console?us-east-1
   Username: user02@f5.io / Password: B4Agility2017X4Y
   WAF ELB
     URL: https://waf-user02f5io-1627564819.us-east-1.elb.amazonaws.com

   BIG-IP Autoscale Instance: waf-user02f5io
     MGMT IP:      52.207.200.169
      STATUS:      MCPD is up, System Ready
    MGMT URL:      https://52.207.200.169:8443
         SSH:      ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no  -o ConnectTimeout=3 -i MyKeyPair-user02@f5.io.pem admin@52.207.200.169

   Big-IP1: ha-user02f5io-vpc-b7b1c7ce
     MGMT IP:      34.232.9.141
      STATUS:      MCPD is up, System Ready
    MGMT URL:      https://34.232.9.141
         SSH:      ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no  -o ConnectTimeout=3 -i MyKeyPair-user02@f5.io.pem admin@34.232.9.141
      VIP IP:      10.0.1.223
   Elastic IP:     52.6.236.56

   Big-IP2: ha-user02f5io-vpc-b7b1c7ce
     MGMT IP:      34.195.89.147
      STATUS:      MCPD is up, System Ready
    MGMT URL:      https://34.195.89.147
         SSH:      ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no  -o ConnectTimeout=3 -i MyKeyPair-user02@f5.io.pem admin@34.195.89.147
      VIP IP:      10.0.2.238

   web-az1.0: user02f5io
     PRIVATE IP:   10.0.1.131

   web-az2.0: user02f5io
     PRIVATE IP:   10.0.2.219

Sample output above. lab-info will quickly orient you around our deployment. All of the same information is available via the AWS Console, the lab-info script is here for convenience.

   - We have an application behind an F5 autoscale WAF that can be reached by the WAF ELB URL.

   - The web-az1.0 and webaz2.0 PRIVATE IP addresses will soon be configured as pool members for our Big-IP HA cluster.

   - Big-IP1 and Big-IP2 are configured as a high availability cluster across two separate availability zones. Only the active Big-IP will have an Elastic IP address assigned. Configuration changes to the active unit will automatically propagate to the standby unit. During an outage, even one affecting an entire availability zone, the Elastic IP will 'float' over to the unit that is not affected.

   - BIG-IP Autoscale Instance is a single NIC deployment WAF with the MGMT IP address identified.

2. From the f5-super-netops container test out application behind the auto-scale waf is up. Replace the example https url with the one specific to your lab. See lab-info.

.. code-block:: bash

   curl -kI https://waf-user01f5io-499431932.us-east-1.elb.amazonaws.com


-- code-block:: bash

   HTTP/1.1 200 OK
   Accept-Ranges: bytes
   Content-Type: text/html
   Date: Sat, 29 Jul 2017 15:50:12 GMT
   Set-Cookie: TS01e70004=01eeb64b413ca1778c867b0174b4a4e8901d5361c37a2ef5634917272e2f6f9b77d14ed447d3903a5e45d1aeb723a0af78bd798f1a; Path=/
   X-COLOR: a0bf37
   Connection: keep-alive

...The HTTP/1.1 200 OK status code i a sign that things went well and we can start configuring the Big-IPs to responsibly fulfill our part of the shared responsibility security model: https://aws.amazon.com/compliance/shared-responsibility-model/

.. image:: https://d0.awsstatic.com/security-center/NewSharedResponsibilityModel.png
