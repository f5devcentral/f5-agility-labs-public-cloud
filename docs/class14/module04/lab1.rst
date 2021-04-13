Basic network plumbing and services
-----------------------------------
In this step you will be validating that the BIG-IPs are configured as specified in the Declarative Onboarding declarattions posted in the last step.

On Big-IP1, Network => VLANs. traffic VLAN was created via DO.

.. image:: ./images/6_bigip1_do_vlan.png
	   :scale: 50%

On Big-IP1, Network => Self IPs. traffic-self VLAN was created via DO.

.. image:: ./images/7_bigip1_do_self_ip.png
	   :scale: 50%

On Big-IP1, Network => Interfaces. Interface 1.1 is UP.

.. image:: ./images/8_bigip1_do_interfaces.png
	   :scale: 50%

On Big-IP1, System => Configuration => Device => NTP was configured.

.. image:: ./images/9_bigip1_do_ntp.png
	   :scale: 50%

On Big-IP1, System => Configuration => Device => DNS was configured.

.. image:: ./images/10_bigip1_do_dns.png
	   :scale: 50%

