Deploy Hackazon App using F5 Declarative AS3 Template
-----------------------------------------------------

**Delete hackazon_vs**

#. From the BIG-IP GUI, select **Local Traffic->Virtual Servers** page
#. Select **check box** next to :guilabel:`hackazon_vs` then click **delete**.
#. Select **delete** again to confirm deletion.
#. Open a browser and go to :guilabel:`https://<Elastic IP>` for the **Hackazon website**. It should no longer be working.

**Deploy F5 Application Services**

#. On the Super-NetOps host, type :guilabel:`ansible-playbook playbooks/hackazon.yaml`.
#. Enter **BIG-IP Username** and **Password** when prompted.

   .. NOTE::

      This will deploy the new app services along with associated :guilabel:`waf_baseCredentials`, :guilabel:`waf_log` and :guilabel:`hackazon-clientssl.prf` created in previous labs.

   .. image:: ./images/image418.png
      :height: 400px

#. From the BIG-IP GUI, select **Local Traffic->Virtual Servers** page and note no virtual server is listed.
#. On the **Partition** drop down menu select :guilabel:`Hackazon` to reveal :guilabel:`serviceMain` virtual server.

   .. image:: ./images/image419.png
      :height: 400px

#. Open a browser and go to :guilabel:`https://<Elastic IP>` for the **Hackazon website**.  It should now be working again.
