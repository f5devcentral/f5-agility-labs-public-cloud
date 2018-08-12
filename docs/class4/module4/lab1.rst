Deploy Hackazon App using F5 Declarative AS3 Template
-----------------------------------------------------

**Delete hackazon_vs**

#. From the BIG-IP GUI, select **Local Traffic->Virtual Servers** page
#. Select check box next to ``hackazon_vs`` then click ``delete``.
#. Select ``delete`` again to confirm deletion.
#. Open a browser and ensure hackazon app is no longer working.

**Deploy F5 Application Services**

#. On the Jump host, type ``ansible-playbook playbooks/hackazon.yaml.  Enter BIG-IP Username and Password when prompted.  This will deploy the new app services along with waf policy created in Lab3. If successful, you will see similar results.


   .. image:: ./images/image418.png
      :height: 400px

#. Open a browser and ensure hackazon app is working again.
#. From the BIG-IP GUI, select **Local Traffic->Virtual Servers** page.  Note there are no virtual servers listed.  You will need to select ``Hackazon`` partition on the top right to view the ``serviceMain`` service.

   .. image:: ./images/image419.png
      :height: 400px

#. Select **serviceMain** then **Security->Polocies** and note the ``waf_baseCredentials`` created earlier is being used.
