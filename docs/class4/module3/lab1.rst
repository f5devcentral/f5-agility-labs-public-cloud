Create WAF logging profile
--------------------------
**Create a logging profile to capture events associated with the WAF policies.**

#. Select **Security->Event Logs->Logging Profiles** then click **Create**
#. For **Profile Name** enter :guilabel:`waf_log`
#. Select the **Application Security, Dos Protection**, and **Bot Defense** checkboxes

   .. image:: ./images/image301.png
      :height: 200px

#. On the **Application Security** tab, for **Request Type** select **All requests**

   .. image:: ./images/image302.png
      :height: 150px

#. On the **DoS Protection** tab select the **Local Publisher** checkbox

   .. image:: ./images/image303.png
      :height: 150px

#. On the **Bot Defense** tab select the **Local Publisher, Log Illegal Requests** and **Log Challenged Requests** checkboxes

   .. image:: ./images/image304.png
      :height: 200px

#. Click **Finished** and you should see a :guilabel:`waf_log`

   .. image:: ./images/image305.png
      :height: 200px
