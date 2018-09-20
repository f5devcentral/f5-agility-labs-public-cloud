Introduction to F5 Orchestration with Ansible 
=============================================

In this lab we will start a docker container running ansible and use a
playbook created in advance to create an environment in Azure. The
specific components which will be created are a virtual network in
Azure, spin up BIG-IP, configure the BIG-IP, and spin up a few Linux
hosts do serve as pool members. The configuration will all be done from
a Linux host in the Ravello Cloud. The location of the Linux host used
for configuration does not need to be in Azure. It can be in your data
center, in a docker container environment on a laptop, or in any cloud
of your choice. The Linux host running the docker container for this
lab will be accessed through Ravello and is actually running in AWS.

The Linux host in the Ravello cloud is preloaded with Ansible, Python
and Docker. 

Automation makes this a repeatable process as demonstrated by the
entire class performing this same operation using the same ansible
playbook. The selection of Ansible is arbitrary. Ansible uses the REST
implementation to configure the BIG-IP and the other components in the
environment. Many other tools can be used for orchestration including,
but not limited to python, terraform, Puppet, and Chef. 

Log on to the Ravello jumphost using the FQDN assigned by the
instructor. All work in this lab will be done from the jumphost using
the Browser and Terminal functions. 

|image3|

Accessing Ravello Jump Host and deploy BIG-IP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. When prompted for credentials

   - Username: ``Ubuntu``
   - Password: ``supernetops``
   - Open the terminal window
   - Adjust the font size using the :guilabel:`Zoom In`
   - Size the window
   
Build and run a docker container with ansible playbook
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the following steps you will build and run a Docker container called
:guilabel:`agility2018` which will have Ansible installed. From the
Docker container, you will provide the required configuration and
authentication credentials to deploy an application into the Azure
environment in a fully automated way. 

#. Clone the github repository to the Linux Host

   .. NOTE::
      This part is optional for Agility lab

   - ``git clone https://github.com/ajgerace/azure-f5``

   - View the contents of the directory. Note the addition of a
     subdirectory called :guilabel:`azure-f5`

   - ``ls``
   - Change directory to the :guilabel:`azure-f5`
   - ``cd azure-f5``

#. Build Docker container (hint: note the period at the end of the
   command. 
   
   .. NOTE::
      Optional for Agility lab

   - ``sudo docker build -t agility2018 .``

     .. NOTE::
        A space is required after the period for this command to work
      
   - Verify that the :guilabel:`agility2018` container exists and look
     at the other docker containers currently on the system

   - ``sudo docker images``

#. Run the Docker container

   - ``sudo docker run -it --rm agility2018``

     .. NOTE::
        Note the change at the prompt. You are now working inside the
        Docker container

   - Prompt is now ``/home/ansible``
   
#. Clone the github repository to the Docker container (we use
   different components of the repository inside the container) and
   build a system using the existing Ansible playbook

   - ``git clone https://github.com/ajgerace/azure-f5``

   - Create environment variables utilizing the student ID and password
     provided by the instructor

   - ``export AZURE_USERNAME=student#@f5custlabs.onmicrosoft.com``

     .. NOTE::
        Insert the correct values in the username

   - ``export AZURE_PW=ChangeMeNow123``
   - Run bash script to create the Azure Service Principal and Secret
   - ``cd azure-f5``
   - ``./spCreate.sh``
   - Output will look something like.....

   |image201|

#. **Troubleshooting tip**---If all the values do not populate, the
   service principal was not created correctly or already exists. If
   this happens, access the Azure portal to delete the Service
   Principal for your student ID
	 
   - Login to Azure Portal
   - https://portal.azure.com
   - USERNAME: ``student#@f5custlabs.onmicrosoft.com``
   - Password: ``ChangeMeNow123``
   - Click on :guilabel:`Azure Active Directory`
   - Click :guilabel:`App registration`
   - Click on your app (:guilabel:`studentX-app`)
   - Click :guilabel:`delete`

   - rerun ``./shCreate.sh`` and verify that all values in the Service
      Principal field are populated 

#. Create the :guilabel:`group_vars/all/vault.yml` file with the variables in
   the black section and verify the contents

   - ``vi group_vars/all/vault.yml``
   - Paste the azure variables created in step 5 in and save the file

   - Save - Write access the Azure portal to delete the Service
      Principal for your student IDthe vault.yml file

   - ``<esc>:wq``
   - ``cat group_vars/all/vault.yml``

#. Create the vault password file. This file will hold the vault
   password so that you will not have to input the password on the
   command line or be prompted for the password when running the playbook.

   - ``echo "@g!l!+y2018" > .vault-pass.txt``
   - Encrypt the :guilabel:`vault.yml` file
   - ``ansible-vault encrypt group_vars/all/vault.yml``
   - View the encrypted :guilabel:`vault.yml` file 
   - ``cat group_vars/all/vault.yml``
   - View the contents of the encrypted :guilabel:`vault.yml` file 
   - ``ansible-vault view group_vars/all/vault.yml``

#. View the contents of :guilabel:`group_vars/azure-f5.yml`. Note the
   prefix variable and the various IP addresses. This is the variable
   input file to the ansible playbook. 

#. Run Ansible playbook with ``deploy_state=present`` to create
   deployment

   - ``ansible-playbook -i notahost, f5agility.yml -e deploy_state=present``
   - **This step will take about 20 minutes**
   - Once complete review the comments on the screen.

     - Note the URI for BIG-IP management
     - Note the URI for the VIP which was created

   |image202|

Inspect the objects created in the Azure environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Let's take a look at what was built by the process in Azure. This
section will focus on the IP address and ACL implementation. By default,
Azure provides restrictive ACLs and NAT functionality to secure the
deployment.  Review any other objects of interest. No changes to the
configuration will be required. 

- Access the Azure portal
- https://portal.azure.com

  - Username: ``student#@f5custlabs.onmicrosoft.com``
  - Password: ``ChangeMeNow123``

- Gather information about the Management port on the BIG-IP
- Resource Groups
- Inspect the BIG-IP virtual machine object

  - :guilabel:`f5vm01`

- Inspect the object which contains the BIG-IP management address

  - :guilabel:`student#-mgmt-pip`
  - Note the Public IP Address
  - :guilabel:`student#-mgmt-nsg`
  - Notice that 443 and 22 are permitted

  - Notice that only one source IP address is allowed to connect.
    The allowed IP address is the IP of the Ravello Jump Host used
    to build the environment

- Inspect the object which contains the external IP mapping

  - :guilabel:`student#-ext`
  - Select IP configurations from the panel on the left

  - Note the Public IP Address and Private IP address associated with
    :guilabel:`student#_rg-ext-ipconfig0`

  - You will browse to the VIP associated with Public IP address to
    connect to the application VIP

  - The Private IP address will be configured as a VIP on the BIG-IP
  - :guilabel:`student#-ext-nsg`
  - Notice that ports 443 and 22 are permitted

  - Notice that only one source IP address is allowed to connect. In a
    typical environment this would be less restrictive, possibly any.

- Inspect the network address assignments on the 2 Linux servers
  created by the orchestration script

  - :guilabel:`vm_bodgeit01_inf` - Network interface
  - :guilabel:`vm_bodgeit02_inf` - Network interface		
  - Select :guilabel:`IP configurations` from the panel on the left

- You could browse to the Public IP address  

- The Private IP address will be configured as a pool member on the
  BIG-IP

- Inspect the object which contains the Linux Server access list

  - :guilabel:`vm_bodgeit01_inf` - Network security group
  - :guilabel:`vm_bodgeit02_inf` - Network security group
  - Notice that only port 22 is permitted

  - Notice that any source IP address is allowed to connect. Typically
    those would be much more restrictive


Inspect the BIG-IP Configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- ``https://<BIG-IP-MGMT-IP-ADDRESS>`` (from the ansible output or
  look at the management interface in the Azure portal)

  - Username: ``student#``
  - Password: ``ChangeMeNow123``

- Inspect the VIP on the BIG-IP

  |image203|  
   
- Inspect the pool on the BIG-IP

  |image204|

Verify that you can connect to the application through the BIG-IP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Access the application

   - ``http://<Public-IP mapped to the VIP address>`` (from the ansible
     output or look at the management interface in the Azure portal)


Inspect the Ansible Playbook
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Return to the Terminal window
- Prompt is now ``/home/ansible``
- **If you closed the terminal window, restart the ansible
  container**

  - ``sudo docker ps -a`` (this will allow you to see the CONTAINER ID)
  - ``sudo docker exec -it <CONTAINER ID> /bin/sh``
       
- View the variable assignments in the :guilabel:`group_vars/azure-f5.yml`

  - ``cat group_vars/azure-f5.yml``

- View the :guilabel:`f5agility.yml` file. This is the Ansible code
  which controls the execution of the individual playbooks. Playbooks are
  referred to as roles in this file.

  - ``cd azure-f5``
  - ``cat f5agility.yml | more``

- View the directories where the playbooks are stored

  - ``cd roles``
  - ``ls``

- Inspect a few of the playbooks

  - ``cd <subdirectory>/tasks``
  - ``cat main.yml | more``
    
Add a VIP to the existing Application environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. In the following steps we will use Ansible to add a Public to
   Private IP mapping and create an additional VIP on the BIG-IP

   - Return to the Terminal window
   - Navigate to :guilabel:`/home/ansible/azure-f5`

   - To add secondary IP to the Azure environment you will run another
     playbook

   - ``ansible-playbook -i notahost, f5agility_add_ip.yml -e deploy_state=present``

   - To create second vip on the existing BIG-IP you will run another
     playbook

   - ``ansible-playbook -i notahost, f5agility_create_vs2.yml -e deploy_state=present``
   
#. Let's take a look at the Ansible Playbooks used to create the objects
   (Public IP in Azure and a VIP on the BIG-IP)

   - Inspect the following files from the
     :guilabel:`/home/ansible/azure-f5` directory. The first 4 are used
     to create the Azure components and the last 3 are used to create
     the VIP on the BIG-IP

     - :guilabel:`f5agility_add_ip.yml`
     - :guilabel:`group_vars/azure-f5.yml`
     - :guilabel:`group_vars/ipconfigs.yml`
     - :guilabel:`roles/add_priv_ip/tasks/main.yml`
     - :guilabel:`f5agility_create_vs2.yml`
     - :guilabel:`group_vars/azure-f5.yml`
     - :guilabel:`roles/create_vs2/tasks/main.yml`

#. Let's take a look at the configuration changes on ther BIG-IP and
   the Azure environmet

   - Access BIG-IP Management interface

     - Username: ``student#``
     - Password: ``ChangeMeNow123``

   - Local :menuselection:`Traffic --> Virtual Servers --> Virtual
     Server List`

   - Note that :guilabel:`bodgedit_vs2` is present. IP address
      :guilabel:`10.0.10.247`

   - Access the Azure portal
   - https://portal.azure.com 

     - Username: ``student#@f5custlabs.onmicrosoft.com``
     - Password: ``ChangeMeNow123``
     - Inspect the external network interface in Azure
     - Resource Groups
     - Select your Resource Group :guilabel:`<student#_rg>`
     - Inspect the BIG-IP virtual machine Network Interface object
     - :guilabel:`student#-ext`
     - IP Configurations from the tool list on the left of the screen
     - Note the Public IP associated with :guilabel:`10.0.10.247`

Test the newly created VIP
~~~~~~~~~~~~~~~~~~~~~~~~~~

- Open a new browser window
- `http://<public_IP associated with 10.0.10.247>`
   
Destroy the environment and verify that the objects were deleted
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Run the ansible playbook with ``deploy_state=absent``
- ``ansible-playbook f5agility.yml -e deploy_state=absent``
- **This step takes about 15 minutes**
- Access the Azure portal
- ``https://portal.azure.com``
- Username: ``student#@f5custlabs.onmicrosoft.com``
- Password: ``ChangeMeNow123``
- Verify that the Resource group and associated objects is removed

.. |image3| image:: /_static/class4/image3.png
   :width: 3.40625in
   :height: 4.04167in
.. |image202| image:: /_static/class4/image202.png
   :width: 5.40625in
   :height: 2.04167in
.. |image201| image:: /_static/class4/image201.png
   :width: 5.40625in
   :height: 4.04167in
.. |image203| image:: /_static/class4/image203.png
   :width: 5.40625in
   :height: 3.04167in
.. |image204| image:: /_static/class4/image204.png
   :width: 4.94792in
   :height: 6.20833in
.. |image106| image:: /_static/class4/image106.png
   :width: 6.32292in
   :height: 3.05208in
