Basic network plumbing and services
-----------------------------------
In this step you will be validating that the BIG-IPs are configured as specified in the Declarative Onboarding declarattions posted in the last step.

On both BIG-IP's, you can SSH or check TMUI and validate that the following items are configured:

Network -> Self-IP addresses
Network -> Routes
Network -> Interfaces
LTM -> Virtual Servers
Device Management -> Devices

Now that you see both BIG-IPs have their base configuration, you'll move on to building a Device Service Cluster (DSC) that is active/standby.

