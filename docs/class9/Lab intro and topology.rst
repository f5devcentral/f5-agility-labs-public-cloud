Lab Contents
---------------
This GCP-121 class consist of following tasks:

- Task 1: Deploy single-NIC BIGIP-A using Google Cloud Console.
- Task 2: Deploy single-NIC BIGIP-B using Google Deployment Manager.
- Task 3: Deploy Google Load Balancer and test failover between BIGIP-A and BIGIP-B.

All the Google Cloud resources (vpc, subnets etc.) are pre-configured for this lab.
In single_NIC setup, all access to the BIG-IP VE is through the same IP address and virtual network interface (vNIC). Because only one self IP address is available in this configuration, the BIG-IP VE high availability feature is not available.  (You cannot create an active-standby pair.). We will leverage Google loadbalacner to support high availability (with active-active setup).

Lab Topology
---------------
.. image:: ./images/topology.png


Connecting to Google Cloud Console
--------------------------------------

Your labuser account, and shortUrl value will be announced at the start of the lab.

- Use Browser with Incognito mode.
- Open console.cloud.google.com
- Login using the provided username and password.


Connecting to the Window Jumphost
---------------------------------
- RDP to 35.197.78.160
- Login using the provided username and password.

Lab Variables
-------------

The lab will make use of unique variables to provide access to the lab
- Username and password
- Labuser number
- BIG-IP VE Evaluation keys.

============== ===========================================================
Variable Name   Variable Value
============== ===========================================================
 shortUrl       Unique key that provides access to this lab (i.e. abc123)
 emailid        Account name for each student (i.e. user1@agility20.com)
============== ===========================================================


IP Address
-------------
============== =============== ==========================================
Device Name     IP Address            Zone
============== =============== ==========================================
 BIGIP-A       10.1.1.x/16            us-west1-a
 BIGIP-B       10.1.2.x/16            us-west1-b
============== =============== ==========================================
Replace "x" with you lab user number. For example, BIGIP-A address for labuser1 will be 10.1.1.1/16.



Backend Address
---------------
============== =============== ==========================================
Device Name      IP Address            Zone
============== =============== ==========================================
 web-server1       10.3.1.1/16            us-west1-a
 web-server2       10.3.2.1/16            us-west1-b
============== =============== ==========================================
The backend servers are pre-configured and no need to create them.
