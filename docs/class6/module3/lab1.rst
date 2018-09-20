
Modify the Ansible configuration to re-deploy an HA pair of big-IP’s with the same application environment
===================================================================================================================

In this lab we will modify the existing Ansible playbook to create an HA environment in Azure. The specific components which will be created are a virtual network in Azure, 2 BIG-IP’s in HA configuration, configure the BIG-IPs, and spin up a few Linux hosts do serve as pool members. The configuration will all be done from a Linux host in the Ravello Cloud. 

This lab assumes that you have completed LAB 2 which includes build and run the docker container and creating the credential vault. 

 #. Return to the Terminal window

    - Prompt is now /home/ansible/azure-f5
    - **Troubleshooting tip** If you closed the terminal window restart the container with the 2 steps below
    - sudo docker ps -a (this will allow you to see the CONTAINER ID)
    - sudo docker exec -i  -t <CONTAINER ID> /bin/sh 

 #. Edit group_vars/azure-f5.yml file to enable deployment of A/P BIG-IP cluster.

    - Change the following variables

      +----------------+------------------+-------------------+
      | Variable       | Existing Value   + New Value         |
      +================+==================+===================+
      | deployment     | 2nic             | ha                |
      +----------------+------------------+-------------------+
      | extVipAddr1    | 10.10.10.246     | 10.10.10.10       |
      +----------------+------------------+-------------------+

 #. Let's take a look at the Ansible Playbooks used to create the objects (BIG-IP, BIG-IP configuration, and Linux servers) instead of running the 2nic playbook, this deployment will run the bigip_ha playbook.

    - View the variable assignments in the group_vars/azure-f5.yml
    - cat group_vars/azure-f5.yml
    - View the f5agility.yml file. This is the Ansible code which controls the execution of the individual playbooks. Playbooks are referred to as roles in this file. 
    - cat f5agility.yml | more
    - View the directories where the playbooks are stored
    - ls
    - Inspect a one or more of the playbooks
    - cd bigip_ha/tasks
    - cat main.yml | more
    - cd /home/ansible/azure-f5
   
 #. Re-run the Ansible playbook to create the new deployment. A message is displayed to console with the public IP addresses for the BIG-IP management interfaces as well as the virtual server.

    - ansible-playbook -i notahost, f5agility.yml -e deploy_state=present
    
      |image301|

 #. Let’s take a look at the BIG-IP configurations which were created. Access both BIG-IP’s using the information provided in the final comments following the TASK deployment. You can also access this information in the resource group objects on the Azure portal. In this exercise, the main focus will be the HA configuration. 

    - Access BIG-IP Management interface
    - https://<BIG-IP-MGMT-IP-ADDRESS> (Obtain this info from the ansible output or the Azure portal)
    - Username: student#
    - Password: ChangeMeNow123
    - Determine which BIG-IP is active and perform the following on the GUI
    - Device Management>>Devices
    - Failover Objects (tab at top of page)
    - Note: bodgeit_srvc_dscvry
    - Properties
    - Force to Standby
    - Confirm operation by selecting Force to Standby again
   
    - **Note that while the HA configuration on the BIG-IP in Azure is very similar to traditional HA configurations in an on prem data center, the operation is different. In Azure, an Azure API is triggered when a failover occurs. The public IP associated with a VIP is only assigned to the external network on the active member of the HA pair. Failover time can be greater than 30 seconds when using this method**

      |image302|

    - Inspect the service discovery iApp
    - iApps>>Application Services>>Applications
    - Components
    - Reconfigure

      |image303|

 #. Inspect the HA components in Azure

    - Access the Azure portal
    - https://portal.azure.com 
    - Username: student#@f5custlabs.onmicrosoft.com
    - Password: ChangeMeNow123
    - Notice the Availability set and Microsoft Compute/Virtual Machines
    - https://www.petri.com/understanding-azure-availability-sets 
    - Resource Groups
    - student#-rg
    - Sort using the Type field to move these objects to the top

    |image304|

    - Inspect the External Network Security groups associated with each BIG-IP
    - Resource Groups
    - student#-rg
    - student#-ext0
    - student#-ext1
    - Only one of these objects has a Public IP associated with the VIP 10.10.10.10


    |image305|
   
Destroy the environment and verify that the objects were deleted
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

 #. Run the ansible playbook with deploy_state=absent 

    - ansible-playbook f5agility.yml -e deploy_state=absent
    - **This step takes about 15 minutes**
 #. Access the Azure portal to verify that the objects have been deleted

    - https://portal.azure.com 
    - Username: student#@f5custlabs.onmicrosoft.com
    - Password: ChangeMeNow123
    - Verify that the Resource group and associated objects is removed

FINAL GRADE
~~~~~~~~~~~
Thank you for participating this "F5 Azure Automation" lab. Please complete the **SURVEY** to
let us know how we did. We value your feedbacks and continuously looking
for ways to improve.

**THANK YOU FOR CHOOSING F5 !!!**

.. |image3| image:: /_static/class4/image3.png
   :width: 3.58333in
   :height: 4.96875in
.. |image301| image:: /_static/class4/image301.png
   :width: 6.25126in
   :height: 3.65672in
.. |image302| image:: /_static/class4/image302.png
   :width: 6.25126in
   :height: 3.65672in
.. |image303| image:: /_static/class4/image303.png
   :width: 6.25126in
   :height: 3.65672in
.. |image304| image:: /_static/class4/image304.png
   :width: 6.25126in
   :height: 3.65672in
.. |image305| image:: /_static/class4/image305.png
   :width: 6.25126in
   :height: 3.65672in
