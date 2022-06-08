Verify F5 Cloud Failover is Ready
=================================

The F5 Cloud Failover Extension (CFE) is an iControl LX extension that provides 
L3 failover functionality in cloud environments, effectively replacing Gratuitous 
ARP (GARP). CFE uses a declarative model, meaning you provide a JSON declaration 
using a single REST API call rather than a set of imperative commands. The 
declaration then configures the BIG-IP system with all the required settings 
for cloud failover. 

Navigate to the GCP Compute Engine console and search for your BIG-IP1 device. It will be
named studentX-Y-ZZZZ - where X is the studentID you are using for this
lab and Y is the BIG-IP number. Select the VM instance for BIG-IP1 and then in 
the right hand panel, select the Labels tab.

.. image:: ./images/Lab4.4-AS3_CFE-BIGIP1_GCPConsole.png
   :scale: 60%
   :alt: Labels

You will notice that there is a "Labels" section of this device which
contains the label of "f5-cfe-failover-label" and the value of "studenX," again
where X is the student ID you are using.

.. image:: ./images/Lab4.4-AS3_CFE-BIGIP1_GCPConsoleLabels.png
   :scale: 60%
   :alt: Labels

You can see that the CFE package is installed by navigating to
"iApps => Package Management LX" and note "f5-cloud_failover" package has been
installed on both devices.

.. image:: ./images/Lab4.4-AS3_CFE-BIGIP1_verifyExtension.png
   :scale: 60%


POST F5 Cloud Failover Declaration
----------------------------------

From the files tab click on "Lab4.4-CFE" => highlight all of the text in
"as3_cfe.json". => right click then select Make HTTP Request.

.. image:: ./images/Lab4.4-AS3_CFE-BIGIP1_Make_HTTPRequest.png
   :scale: 60%

A "message:success" response indicates the f5-cloud-failover declaration was
successfully posted.

.. image:: ./images/Lab4.4-AS3_CFE-BIGIP1_Make_HTTPRequest_success.png
   :scale: 60%

Post the declaration to BIG-IP2 as well.  The CFE configuration is not
synchronized as part of the DSC synchronization mechanism.

Test Failover
-------------

From Big-IP1, Device Management => Traffic Groups => traffic-group-1.

.. image:: ./images/Lab4.4-AS3_CFE-BIGIP1_TMUITrafficGroup.png
   :scale: 60%

Force bigip1 to standby. Click [Force to Standby].

.. image:: ./images/Lab4.4-AS3_CFE-BIGIP1_TMUITrafficGroupForcetoStandby.png
   :scale: 60%

.. warning:: If you are not in the "Common" partition, the [Force to Standby] button will be greyed out.  Select /Common and it will now be active.

On Big-IP1, in the upper-left-hand corner, note "ONLINE (STANDBY)".

.. image:: ./images/Lab4.4-AS3_CFE-BIGIP1_TMUIStandby.png
   :scale: 60%

From Big-IP2, in the upper-left-hand corner, note "ONLINE (ACTIVE)". Big-IP2
was immediately promoted to active and Big-IP1 demoted to standby.

.. image:: ./images/Lab4.4-AS3_CFE-BIGIP2_TMUIActive.png
   :scale: 60%

From Big-IP2, Device Management => Traffic Groups => traffic-group-1.

Force bigip2.f5lab.dev to standby. Click [Force to Standby].

.. image:: ./images/Lab4.4-AS3_CFE-BIGIP2_TMUITrafficGroupForcetoStandby.png
   :scale: 50%

On Big-IP2, in the upper-left-hand corner, note "ONLINE (STANDBY)".

.. image:: ./images/Lab4.4-AS3_CFE-BIGIP2_TMUIStandby.png
   :scale: 50%

From Big-IP1, in the upper-left-hand corner, note "ONLINE (ACTIVE)". Big-IP1 is
now back to active.

.. image:: ./images/Lab4.4-AS3_CFE-BIGIP1_TMUIActive.png
   :scale: 50%
