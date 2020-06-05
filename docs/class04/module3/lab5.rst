Update Parent WAF Policy
------------------------
**Task 1 - Simulate attacks to demonstrate newly discovered vulnerability.**

#. Open browser and go to :guilabel:`https://<Elastic IP>/account/documents?page=delivery.html;%20cat%20/etc/passwd`
#. Enter credentials to login successfully.

   .. image:: ./images/image350.png
     :height: 350px

   .. NOTE::

      This is a common :guilabel:`OS command injection` attack. Upon successful login it displayed
      the desired page along with the results for :guilabel:`cat /etc/passwd`.

**Task 2 - Modify the parent waf policy to mitigate the command injection vulnerability**

#. Open the **Security -> Application Security -> Security Policies -> Policies List** page
#. Select :guilabel:`waf_base` then click :guilabel:`waf_base` to view properties

   .. image:: ./images/image351.png
     :height: 200px

   .. image:: ./images/image352.png
     :height: 200px

#. Click on :guilabel:`Attack Signatures Configuration`
#. On the **Attack Signatures** section click **Change**

   .. image:: ./images/image353.png
     :height: 100px

#. Click **OS Command Injection Signatures** check box then click **Change**

   .. image:: ./images/image354.png
     :height: 350px

#. Click **Save** at the bottom of the properties page
#. Click **Apply Policy** to commit changes

   .. image:: ./images/image343.png
     :height: 50px

**Task 6 - Repeat simulated command injection attack**

#. Open browser and go to :guilabel:`https://<Elastic IP>/account/documents?page=delivery.html;%20cat%20/etc/passwd`
#. Your request should be rejected.

   .. NOTE::

      Updates to the Parent policy will be inherited by the Child policies based
      on the Inheritance configuration. Since :guilabel:`waf_base` parent policy
      **Attack Signatures** was **Mandatory** all Child policies inherited the changes.
