Deploy an AWS High-Availability-aware virtual server across two Availability Zones
---------------------------------------------------------------------------------------------

1. From the Linux web shell, run the lab-info utility. This is a quick way to gather the details you'll need to configure the AWS high-availability-aware TCP virtual server.

#. Login to the active Big-IP1 configuration utility (web ui). Using the examples in our lab-info output: https://34.230.189.240.

#. The "HA_Across_AZs" iApp will already be deployed in the Common partition.

#. The "service_discovery" iApp will already be deployed as well.

#. Download the latest iApp package from https://s3.amazonaws.com/f5-marfil/iapps-1.0.0.468.0.zip.

#. Extract \\TCP\Release_Candidates\\f5.tcp.v1.0.0rc2.tmpl. This is the tested version of the iApp.

#. Import f5.tcp.v1.0.0rc2.tmpl to the primary BigIP. The secondary BigIP should pick up the configuration change automatically.

#. Deploy an iApp using the f5.tcp.v1.0.0rc2.tmpl template.

#. Configure iApp:

    - Select "Advanced" from "Template Selection"

    - Traffic Group: UNCHECK "Inherit traffic group from current partition / path"

+--------------------------------------------------------------------------------------------------------------+----------------------------------+
| Question                                                                                                     | value                            |
+==============================================================================================================+==================================+
| Name:                                                                                                        | virtual_server_1                 |
+--------------------------------------------------------------------------------------------------------------+----------------------------------+
| High Availability. What IP address do you want to use for the virtual server?                                | VIP IP of Big-IP1                |
+--------------------------------------------------------------------------------------------------------------+----------------------------------+
| What is the associated service port?                                                                         | HTTP(80)                         |
+--------------------------------------------------------------------------------------------------------------+----------------------------------+
| What IP address do you wish to use for the TCP virtual server in the other data center or availability zone? | VIP IP of Big-IP2                |
+--------------------------------------------------------------------------------------------------------------+----------------------------------+
| Which servers are part of this pool?                                                                         | Private IP of web-az1.0 Port: 80 |
+                                                                                                              +----------------------------------+
|                                                                                                              | Private IP of web-az2.0 Port: 80 |
+--------------------------------------------------------------------------------------------------------------+----------------------------------+

      .. note:: The preconfigured HA_Across_AZs iApp has both IP addresses for the virtual servers prepopulated. The virtual server IP addresses configured here must match the virtual server IP address configured in the HA_Across_AZs iApp.


**Finished!**

10. Login to the standby BigIP configuration utility (web ui) and confirm the changes are in sync.

#. Confirm the virtual server is up!

.. code-block:: bash

   curl http://34.196.122.217

...watch for Hello, World response from Big-IP1.

   StatusCode        : 200

   StatusDescription : OK

   Content           : Hello, World

   ...


.. code-block:: bash

   ./scripts/lab-info

12. AWS Console => Services => Compute => EC2. Right click on the active BigIP1 instance => Instance State => Reboot. In a few seconds, the AWS console and the elastic IP will 'float' over to the second BigIP.

.. code-block:: bash

   ./scripts/lab-info

.. code-block:: bash

   curl http://52.205.85.86

...watch for Hello, World response from Big-IP2. Traditional HA failover relies on Layer 2 connectivity and a heartbeat to trigger a fail-over event and move a 'floating IP' to a new active unit. There is no Layer 2 connectivity in the cloud across availability zones. The Big-IP will detect an availability zone outage or trouble with a Big-IP VE and the elastic IP will 'float' over to the new active device as you just saw.
