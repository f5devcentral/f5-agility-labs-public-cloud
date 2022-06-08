Verify F5 Cloud Failover is Ready
=================================

The F5 Cloud Failover Extension (CFE) is an iControl LX extension that provides 
L3 failover functionality in cloud environments, effectively replacing Gratuitous 
ARP (GARP). CFE uses a declarative model, meaning you provide a JSON declaration 
using a single REST API call rather than a set of imperative commands. The 
declaration then configures the BIG-IP system with all the required settings 
for cloud failover. 

Navigate to the GCP console and search for your BIG-IP1 device. It will be
named studentX-Y-ZZZZ-f5vm01 - where X is the studentID you are using for this
lab. You will notice that there is a "Labels" section of this device which
contains the label of "f5-cfe-failover-label" and the value of "studenX," again
where X is the student ID you are using.

.. image:: ./images/04_gcp_console_labels.png
   :scale: 50%
   :alt: Labels

You can see that the CFE package is installed by navigating to
"iApps => Package Management LX" and note "f5-cloud_failover" package has been
installed on both devices.

.. image:: ./images/00_service_discovery_check.png
   :scale: 50%


POST F5 Cloud Failover Declaration
----------------------------------

From the files tab click on "Lab4.4-CFE" => highlight all of the text in
"as3_cfe.json". => right click then select Make HTTP Request.

.. image:: ./images/01_Select_and_Make_HTTP_Request.png
   :scale: 50%

A "message:success" response indicates the f5-cloud-failover declaration was
successfully posted.

.. image:: ./images/02_cfe_declaration_validation.png
   :scale: 50%

Post the declaration to BIG-IP2 as well.  The CFE configuration is not
synchronized as part of the DSC synchronization mechanism.

Test Failover
-------------

From Big-IP1, Device Management => Devices => bigip1(Self).

.. image:: ./images/11_device_bigip1.png
   :scale: 50%

Force bigip1 to standby. Click [Force to Standby].

.. image:: ./images/12_device_bigip1_force_to_standby.png
   :scale: 50%

.. warning:: If you are not in the "Common" partition, the [Force to Standby] button will be greyed out.  Select /Common and it will now be active.

On Big-IP1, in the upper-left-hand corner, note "ONLINE (STANDBY)".

.. image:: ./images/13_device_bigip1_standby.png
   :scale: 50%

From Big-IP2, in the upper-left-hand corner, note "ONLINE (ACTIVE)". Big-IP2
was immediately promoted to active and Big-IP1 demoted to standby.

.. image:: ./images/14_device_bigip2_active.png
   :scale: 50%

From Big-IP2, Device Management => Devices => bigip2.f5lab.dev.

Force bigip2.f5lab.dev to standby. Click [Force to Standby].

.. image:: ./images/18_device_bigip2_force_to_standby.png
   :scale: 50%

On Big-IP2, in the upper-left-hand corner, note "ONLINE (STANDBY)".

.. image:: ./images/19_device_bigip2_standby.png
   :scale: 50%

From Big-IP1, in the upper-left-hand corner, note "ONLINE (ACTIVE)". Big-IP1 is
now back to active.

.. image:: ./images/20_device_bigip1_active.png
   :scale: 50%

Back to the browser tab with the example application. [CTRL] + [F5] a few times
to refresh the browser. We are using self-signed certificates in the lab.
Bypass the TLS warnings. “Accept the Risk and Continue”.

.. image:: ./images/22_example_app_bigip1_bypass_warning.png
   :scale: 50%

.. image:: ./images/23_example_app_bigip1.png
   :scale: 50%
