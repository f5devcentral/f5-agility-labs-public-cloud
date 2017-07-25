Task 4 - Configuration Utility (Web UI) access
----------------------------------------------

1. Identify the management IP address of each of the three BigIP instances that we created. By defaultt, F5 cloud instances are locked down to ssh key access only. Let's create an admin password so we can login via the configuration utility (web ui). Assuming you are user01 and the management IP address of your F5 instance is 54.165.15.2.

.. code-block:: bash

   ssh -i ./MyKeyPair-user01@f5.io.pem admin@54.165.15.2

2. Create an admin password.

.. code-block:: bash

   modify auth user admin password mylabpass

3. Complete the step above for *all three* Big-IP instances:

   - Big-IP2: ha-user01f5io-vpc-74c7a70d
       MGMT IP:	34.194.27.11

   - BIG-IP Autoscale Instance: waf-user01f5io
       MGMT IP:	54.165.15.2

   - Big-IP1: ha-user01f5io-vpc-74c7a70d
       MGMT IP:	34.230.189.240


Task 5 - Deploy the Service Discovery iApp on a BigIP Cluster across two Availability Zones
-------------------------------------------------------------------------------------------
1. Login to the active Big-IP1 configuration utility (web ui). Using the examples in our lab-info output: http://34.230.189.240.

#. Navigate to iApps. The "HA_Across_AZs" iApp will already be deployed in the Common partition and is automatically configured when you deploy the HA CloudFormation template across availability zones.

#. The Service Discovery iApp will automatically discover and populate nodes in the cloud based on tags.

#. From the configuration utility (web ui) of Big-IP1. iApps => Application Services => Create...

+----------------------------------------------------------------------------+----------------------------------+
| Question                                                                   | value                            |
+============================================================================+==================================+
| Name                                                                       | service_discovery                |
+----------------------------------------------------------------------------+----------------------------------+
| Template                                                                   | f5.service.discovery             |
+----------------------------------------------------------------------------+----------------------------------+
| Pool                                                                                                          |
+----------------------------------------------------------------------------+----------------------------------+
| What is the tag key on your cloud provider for the members of this pool?   | application                      |
+----------------------------------------------------------------------------+----------------------------------+
| What is the tag value on your cloud provider for the members of this pool? | f5app                            |
+----------------------------------------------------------------------------+----------------------------------+
| Do you want to create a new pool or use an existing one?                   | Create new pool...               |
+----------------------------------------------------------------------------+----------------------------------+
| Application Health                                                                                            |
+----------------------------------------------------------------------------+----------------------------------+
| Create a new health monitor or use an existing one?                        | http                             |
+----------------------------------------------------------------------------+----------------------------------+


5. Local Traffic => Pools => track the newly created service_discovery_pool. Within 60 seconds it should light up green. The service_discovery iApp has discovered and auto-populated the service_discovery_pool with two web servers.
