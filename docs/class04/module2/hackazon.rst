Setting up Hackazon Virtual Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**We will now setup an SSL Offload Virtual Server using the Cipher Group previously configured.**

#. Go to the F5 Admin page and select **Local Traffic -> Profiles -> SSL -> Client**

#. Click on **Create**

#. For the **SSL profile name** Enter :guilabel:`hackazon-clientssl.prf`

#. Select **Advanced** configuration.

#. Select the checkbox to **modify Ciphers** and select **Cipher Group** and in the dropdown select :guilabel:`hackazon-ciphergroup` that you created.

   .. image:: ./images/image203a.png

#. Leave other options as default and click on **Finished**

#. Go to **Local Traffic -> Pools**

#. Click on **Create**

#. In the **Pool Name** field enter :guilabel:`hackazon.p`

#. Select the **HTTP health monitor** and move it to **Active**

#. Put in the following two IP addresses into the list of pool members both on port 80:  **18.205.1.169**, and **34.239.240.82**

   .. image:: ./images/image204.png
      :height: 400px

#. Click on **Finished**

#. Go to the AWS console, Select **Services** and then **EC2**. Select **Instances**  Filter for your ``student#`` and select the checkbox for the one labeled :guilabel:`BIG-IP:Student#-CFT`.

#. In the description for the instance there is a list of **Elastic IPs**.  Click on the last one in the list.  It will also not have a * at the end of the IP address.

#. In the definition of the Elastic IP there will be a **Private IP address**.  This IP will become your Virtual Server Destination address.  The **Elastic IP** will be the IP for accessing the application.

   .. image:: ./images/image202.png

   This screenshot illustrates one example. The presented IP addresses will not be the ones you see

#. Go to **F5 Admin page** and then **Local Traffic -> Virtual Servers**

#. Click on **Create**

#. Enter a **Virtual Server Name** of :guilabel:`hackazon_vs`

#. In the **Destination Address** field enter :guilabel:`Private IP address that you determined earlier as part of the Elastic IP information.`

#. For **Service Port** enter :guilabel:`443`

#. For **HTTP Profile** select :guilabel:`HTTP` from the dropdown menu.

#. In the **SSL Profile (client)** field move :guilabel:`hackazon_clientssl.prf` from **Available** into **Selected**

#. In the **Source Adress Translation** select :guilabel:`Automap`

#. In the **Resources** section under **Default Pool** select :guilabel:`hackazon.p` from the dropdown list.

   .. image:: ./images/image205.png
      :height: 500px

#. Click on **Finished**

#. Now take the **Elastic IP** you found earlier in the AWS Console, open a web browser and go to :guilabel:`https://<Elastic IP>`.  You will get a certificate error because we are not using a domain specific SSL Certificate.  Once ignoring the certificate error you should start seeing the hackazon web page.