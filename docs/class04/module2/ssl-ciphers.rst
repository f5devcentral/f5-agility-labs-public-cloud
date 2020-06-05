Securing the SSL for the Application
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Starting in v13.0 the allowed SSL Ciphers can be managed with a combination of SSL Cipher Rules to create a Cipher Group.  Using a combination of the Cipher Rules you can create a secure Cipher Group that will protect your application and allow only the clients with good ciphers necessary for your needs.  

**SSL Cipher Rules can be combined in the groups as follows:**

   .. image:: ./images/image201.png
      :height: 500px

#. We will start by creating a SSL Cipher Rule.  Click on **Local Traffic -> Ciphers -> Rules** then **Create**

#. In the **Name field** enter :guilabel:`hackazon-cipherrule`

#. For the **Cipher String** enter:

     :guilabel:`!SSLv2:!EXPORT:!DHE+AES-GCM:!DHE+AES:!DHE+3DES:ECDHE+AES-GCM:ECDHE+AES:RSA+AES-GCM:RSA+AES:ECDHE+3DES:RSA+3DES:-MD5:-SSLv3:-RC4`

#. Click on **Finished**

#. Now click on the **Groups** Tab.

#. Click on **Create**

#. For the **Cipher Group name** enter :guilabel:`hackazon-ciphergroup`

#. Select the **hackazon-cipherrule** previously created and add it to the **Allow the Following** category. 

#. Down at the bottom of the Cipher Group configuration will be a list of the allowed Ciphers.  With the above string you will get a security configuration that will still allow some older clients like WindowsXP and IE8.  You can further secure it by removing TLSv1 or making it so the default f5-ecc cipher rule is in the **"Restrict the Allowed List to the Following."**

#. Click on **Finished**