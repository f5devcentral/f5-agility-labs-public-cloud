Create Base WAF Child Policy
----------------------------
**Task 1 - Simulate attacks to demonstrate common web app vulnerabilities.**

#. Open browser and go to :guilabel:`https://<Elastic IP>` to access the **Hackazon website**
#. Under **Special selection** click on any sale item displayed
#. Note the **product id** in the browser address bar

   .. image:: ./images/image392.png
     :height: 400px

#. In the browser address bar append :guilabel:`or 1=1` then press **Enter**

   .. image:: ./images/image393.png
     :height: 50px

   .. NOTE::

      This is a common :guilabel:`sql injection` attack and although this did not return
      anything exciting the search request was accepted and processed with response.

#. In the **Search field** enter :guilabel:`<script>alert("Your system is infected! Call 999-888-7777 for help.")</script>` and press **Enter**

   .. NOTE::

      This is a common :guilabel:`Cross-site scripting (XSS)` attack and although this did not return
      anything exciting the search request was accepted and processed with response.

      Also some modern versions of browsers will block this request from displaying a response, but the request was actually sent to the application.  If Chrome blocks it you can try on another browser.

**Task 2 - Create new waf policy to mitigate the vulnerabilities using info on table below:**

.. list-table::
    :widths: 20 40
    :header-rows: 0
    :stub-columns: 0

    * - **Policy Name**
      - waf_baseOnly
    * - **Policy Type**
      - Security
    * - **Parent Policy**
      - waf_base
    * - **Virtual Server**
      - hackazon_vs
    * - **Enforcement Mode**
      - Blocking

#. Select the **Security->Application Security->Security Policies->Policies List** page
#. Click **Create New Policy**
#. Select **Advanced** options
#. For **Policy Name** enter :guilabel:`waf_baseOnly`
#. For **Policy Type** select :guilabel:`Security`
#. For **Parent Policy** enter :guilabel:`waf_base`
#. Select **OK** to accept warning
#. For **Virtual Server** select :guilabel:`hackazon_vs`
#. Change **Enforcement Mode** to :guilabel:`Blocking`

   .. image:: ./images/image311.png
     :height: 400px

#. Click **Create Policy**

   .. image:: ./images/image312.png
     :height: 400px

   .. NOTE::

      This creates a child security policy which inherits the settings from the
      waf_base Parent Policy.  The parent policy settings was created using Rapid
      Deployment Template which includes several common security measures and
      thousands of attack signatures. Signature Staging is Disabled for this lab
      demo but most likely will be enabled for production environments.

**Task 3 - Test WAF policy.**

#. Select the **Local Traffic->Virtual Servers->Virtual Servers List** page
#. Click the **hackazon_vs** to display Virtual Server Properties
#. Click the **Security->Policies** tab to display Policy Settings
#. In the **Log Profile** ensure :guilabel:`waf_log` profile is selected
#. Select **update**

   .. image:: ./images/image313.png
     :height: 300px

#. Open browser and go to :guilabel:`https://<Elastic IP>/product/view?id=101 or 1=1`.  You should receive a block message similar to below. Take note of the **Support ID** number.

   .. image:: ./images/image314.png
     :height: 70px

#. Return to hackazon main page
#. In the **Search** field type :guilabel:`<script>alert("Your system is infected! Call 999-888-7777 for help.")</script>` and press **Enter**.  You should see a similar block message. Take note of the **Support ID** number.

**Task 4 - Review WAF event logs on BIG-IP GUI.**

#. Select the **Security->Event Logs->Application->Requests** page
#. Select the :guilabel:`Event` with the matching :guilabel:`Support ID` noted on the block pages

   .. image:: ./images/image315.png
     :height: 300px


   .. NOTE::

      You can view the "Decoded Requests" and the "Original Request" however the "Response" is not captured by default.

#. Select :guilabel:`Attack Signatures Detected` to view details of the request that triggered the violation.

   .. image:: ./images/image316.png
     :height: 200px
