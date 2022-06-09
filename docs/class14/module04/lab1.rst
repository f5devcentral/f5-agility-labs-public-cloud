Basic network plumbing and services
===================================

In this step you will be validating that the BIG-IPs are configured as
specified in the Declarative Onboarding declarattions posted in the last step.

On both BIG-IP's, you can SSH or check TMUI and validate that the following
items are configured:

* Network -> Self-IP addresses
* Network -> Routes
* Network -> Interfaces
* Device Management -> Devices

.. note:: LTM -> Virtual Servers will still show nothing configured.  
    Declarative Onboarding configures device specific details, not services.  
    Services will be handled in your later lab modules.

Now that you see both BIG-IPs have their base configuration, you will move 
on to configure the Telemetry Streaming so that it has time to begin sending 
data to Google.  Then you will move on to building a Device Service Cluster (DSC) that is active/standby.
