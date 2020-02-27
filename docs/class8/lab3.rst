Lab 3: Introduction to the F5 Cloud Failover Extension
====================================================

The purpose of this lab is to install the cloud failover extension after deploying your API based failover google cloud template.

The F5 cloud failover extension has three main benefits:

Standardization: Failover patterns will look similar across all clouds.
Portability: You can leverage a variety of methods, including cloud-native templates, Terraform, and Ansible, to install and run CF.
Lifecycle and Supportability: You can upgrade BIG-IP without having to call F5 support to fix failover.

Objective:
----------

-  Gain an understanding of how the cloud failover extension is implemented in Google Cloud.


Lab Requirements:
-----------------

-  Completed Lab1 "Deploying GDM Template"

-  Estimated completion time: 40 minutes

Excercise: Install Cloud Failover Extension
-------------------------------------------

Task – Download and Install Cloud Failover Extension RPM
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Install the cloud failover extension on Each Bigip.

Log in to TMUI. From iApps/Package Management LX select the Import button.

**The cloud failover extension file is located at c:\\Users\\Public\\Documents**

**The file is called develop-f5-cloud-failover-0.9.1-1.noarch.rpm**



2. Install the Cloud Failover on each BIG-IP using the Configuration utility¶

From the Configuration utility:

-   If you are using a BIG-IP version prior to 14.0, before you can use the Configuration utility, you must enable the framework using the BIG-IP command line. From the CLI, type the following command: touch /var/config/rest/iapps/enable. You only need to run this command once per BIG-IP system.
-   Click iApps > Package Management LX.
-   Click the Import button.
-   Click Choose File and then browse to the location you saved the RPM file, and then click Ok.
-   Click the Upload button. ::

|image015|



Task – Label Instances and Configure your Failover Declaration wtih Postman
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


1. Using Postman Post the the cloud declaration.

Send two Declarations to each BIG-IP in my pair via Postman. (again following along with the documentation)


2. Install Postman if it is not already installed.

The installer is located at.

**"C:\\Users\\Public\\Public Documents"**

3. Open up postman.

Disable SSL Certificate Verification in postman.

This can be accmplished by going to File/Settings.

|image017|

4. Import the Cloud Failover Extension API collection and configure the baseURL values.


-To import the cloud Failover Extension API collection select File\\Import
-**The collection file is called develop-postman-collection**
-**The collection file is located at c:\\Users\\Public\\Public Documents**



5. EDIT The collection to modify the baseURL values.

Hover over the Cloud Failover (CF) Extension collectin and click the 3 dots on the bottom right and select "Edit". (See image)

|image044|

- Click on the variables tab
- Set the Current value IP to be the IP of bigip1
- Set the Initial value IP to be the IP of bigip2
- Click the Update Button
    
|image045|

6. Using Postman verify the CFE to ensure it is running correctly.

**For Each BigIP** Using a RESTful API client like Postman, send a GET request to the URI https://{{host}}/mgmt/shared/cloud-failover/info to ensure Cloud Failover is running properly

You should receive an expected response like the following after you have posted this declaration. ::

                {
                    "version": "0.9.1",
                    "release": "1",
                    "schemaCurrent": "0.9.0",
                    "schemaMinimum": "0.9.0"
                }


_____

7. Label instances and storage buckets.

**Note this step must be performed from the google cloud console**

Note that the “labels” and “value” can be arbitrary but they must match the tags that you assign to your GCP infrastructure.

- Label instances with for example "f5_cloud_failover_label": "studentx" - where x is your student number
- Label storage bucket for example with "f5_cloud_failover_label": "studentx" - where x is your student number


8. In google create a student specific route.

You will add the route under the Networking/VPC Network/Routes.

**Click the "Create Route Button**


- Route name: labuserx where x is your student number.
      
- Label the description in the route with f5_cloud_failover_labels 
**{"f5_cloud_failover_label":"student16","f5_self_ips":["10.3.0.10","10.3.0.11"]}** 
where x is         your student number.
      
- Network: internal-vpc-221
      
- Destination IP - this will be a 10.1.x.x/29 network that will be unique to each student (see deploying GDM) template         in lab1.
      
- Next Hop: will be an IP address that is an internal self IP address on one of the instances that you deployed in             lab1. The next HOP is the **selfIP on the active Unit**
      
    
|image019|
      
    
9. **For Each BigIP** Using Postman, send a POST request to the URI https://<BIG-IP>/mgmt/shared/cloud-failover/declare

**Note in the example declaration in the postman collection for google the "environment" value is "gce" this needs to be changed to "gcp"**
**Modify the declaration within postman for you student number. Your particular student specific scoping address range and you student specific cloud failover label**
** Your student specific Next Hope IP addresses... note these are "internal" self IP's on your BigIP **

Note.

- The defaultNextHopAddresses should be the selfIP associated with your "internal network"
- The deployment labe should be "studentx" where x is your labuser number.. for instance "student28"::
    
                {
                    "class": "Cloud_Failover",
                    "environment": "gcp",
                    "externalStorage": {
                        "scopingTags": {
                            "f5_cloud_failover_label": "student16"
                        }
                    },
                    "failoverAddresses": {
                        "scopingTags": {
                            "f5_cloud_failover_label": "student16"
                        }
                    },
                    "failoverRoutes": {
                        "scopingTags": {
                            "f5_cloud_failover_label": "student16"
                        },
                        "scopingAddressRanges": [
                            {
                                "range": "10.2.0.240/29"
                            }
                        ],
                        "defaultNextHopAddresses": {
                            "discoveryType": "static",
                            "items": [
                                "10.3.0.7",
                                "10.3.0.8"
                            ]
                        }
                    },
                    "controls": {
                        "class": "Controls",
                        "logLevel": "info"
                    }
                }

_____

Also you should receive a response back from postman that looks like the following.


{"message":"success","declaration":{"class":"Cloud_Failover","environment":"gcp","externalStorage":{"scopingTags":{"f5_cloud_failover_label":"mydeployment"}},"failoverAddresses":{"scopingTags":{"f5_cloud_failover_label":"mydeployment"}},"failoverRoutes":{"scopingTags":{"f5_cloud_failover_label":"mydeployment"},"scopingAddressRanges":["0.0.0.0/0"]},"schemaVersion":"0.9.0"}}


  |image018|


Task – Verify Cloud Failover Scripts 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  

SSH to each box with user1

- then type "run util bash"
- change directory to /config/failover/active
- On each file **tgactive and tgrefresh"** 
- Perform a "more" command .. for example "more tgactive"  
- Note the failvoer extension has disable the Google API failover scripts. You should see something like #Autogenerated by F5 Failover Extension - Trigger failover.. and then some lines that disable the default scripts and add some that are specific to the F5 cloud failover extension.



Task – Test
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Test

Force the active unit to standby while tailing 

- tail –f /var/log/restnoded/restnoded.log on both machines.

You should see something like the following in the log files. ::

                | Sat, 18 Jan 2020 19:28:35 GMT - info: [f5-cloud-failover] Performing failover - execute
                | Sat, 18 Jan 2020 19:28:36 GMT - info: [f5-cloud-failover] Performing Failover - discovery
                | Sat, 18 Jan 2020 19:28:37 GMT - info: [f5-cloud-failover] Performing Failover - update
                | Sat, 18 Jan 2020 19:28:42 GMT - info: [f5-cloud-failover] Update routes successful.
                | Sat, 18 Jan 2020 19:28:43 GMT - info: [f5-cloud-failover] Disassociate NICs successful.
                | Sat, 18 Jan 2020 19:28:49 GMT - info: [f5-cloud-failover] Associate NICs successful.
                | Sat, 18 Jan 2020 19:29:07 GMT - info: [f5-cloud-failover] Updated forwarding rules successfully
                | Sat, 18 Jan 2020 19:29:07 GMT - info: [f5-cloud-failover] Failover complete

_____

|Also you should be able to observe the route that you created and see that the "next hop" value has changed to the selfIP on the other Big-IP.

The lab is now Complete.
------------------------



.. |image015| image:: media/image15.png
   :width: 13.04in
   :height: 9.04in
.. |image017| image:: media/image17.png
   :width: 17.4in
   :height: 10.78in
.. |image018| image:: media/image18.png
   :width: 18.79in
   :height: 7.64in
.. |image019| image:: media/image19.png
   :width: 7.89in
   :height: 9.42in
.. |image044| image:: media/image44.png
   :width: 4.35in
   :height: 2.51in
.. |image045| image:: media/image45.png
   :width: 11.22in
   :height: 9.06in
