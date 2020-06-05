Create Credentials Protection WAF Child Policy
----------------------------------------------
**Task 1 - Simulate credential attacks.**

#. Open browser and go to :guilabel:`https://<Elastic IP>/user/login`
#. For **Username** enter :guilabel:`f5student`
#. For **Password.** enter random incorrect password. Repeat 5 consecutive times using different password to simulate brute force attack

   .. NOTE::

      This is a common :guilabel:`brute force` attack. In this case the application allowed
      repeated attempts without lockout.  Some applications will send "account locked"
      for a period of time, however user can continue to repeated attempts to
      elongate lockout period.

#. Open new **incognito browser** and open **developer tools**. (In Chrome for example: **View -> Developer ->Developer Tools**)
#. Browse to :guilabel:`https://<Elastic IP>/user/login` and login with **username** :guilabel:`f5student` and **password** :guilabel:`password`
#. Once successfully logged in, review log on Developer Tool.

   - Select :guilabel:`Network` tab
   - Highlight :guilabel:`login?return_url=`
   - On right panel click :guilabel:`Headers` and scroll to bottom of **Form Data** to view **Username** and **Password**.

   .. image:: ./images/image340.png
     :height: 400px

**Task 2 - Create new waf policy to mitigate the vulnerabilities using info on table below:**

.. list-table::
    :widths: 20 40
    :header-rows: 0
    :stub-columns: 0

    * - **Policy Name**
      - waf_baseCredentials
    * - **Policy Type**
      - Security
    * - **Parent Policy**
      - waf_base
    * - **Virtual Server**
      - none
    * - **Enforcement Mode**
      - Blocking

#. Select the **Security -> Application Security -> Security Policies -> Policies List** page
#. Click **Create New Policy** then click **Advanced** and enter info as shown in image below.

   .. image:: ./images/image341.png
     :height: 300px

#. Click **Create Policy**

   .. image:: ./images/image339.png
     :height: 300px

**Task 3 - Configure Brute Force Protection**

#. Select **Security -> Application Security -> Sessions and Logins -> Login Pages List** page
#. Click **Create**

   .. image:: ./images/image342.png
     :height: 300px

#. Fill in the details as in the image above and click on **Create**
#. Select **Security -> Application Security -> Anomaly Detection -> Brute Force Attack Prevention** then click **Create**
#. Change **Login Page** drop down box to :guilabel:`[HTTPS]/user/login` then click **Create**
#. Click **Apply Policy** then **OK** to commit changes

   .. image:: ./images/image343.png
     :height: 50px

**Task 4 - Configure Credential Encryption**

#. Select **Security -> Data Protection -> DataSafe Profiles**
#. Click **Create**

   .. image:: ./images/image344.png
     :height: 100px

#. For **Profile Name** enter :guilabel:`protect_credentials`

   .. image:: ./images/image345.png
     :height: 300px

#. Click on the **`>`** next to **Create New Profile** to expand menu.
#. Select **URL List** and click **Add**

   .. image:: ./images/image346.png
     :height: 150px

#. For the **URL path** enter :guilabel:`/user/login`
#. Expand the Menu again and Select **Parameters**
#. In the **Parameter Name** enter :guilabel:`username` and click **Add**
#. Check **Identify as Username** and **Encrypt** check boxes
#. In the **Parameter Name** enter :guilabel:`password` and click **Add**
#. Check **Encrypt** check box

   .. image:: ./images/image347.png
     :height: 150px

#. Click **Login Page Properties**
#. For **URL is Login Page** check **Yes** box
#. For **A string should appear** enter :guilabel:`My Account`
#. For **A string that should NOT appear** enter :guilabel:`Username or password are incorrect`

   .. image:: ./images/image348.png
     :height: 300px
#. Click **Create**

**Task 5 - Assign policies to protect Hackazon App**

#. Select **Local Traffic -> Virtual Servers -> Virtual Servers List** and click on :guilabel:`hackazon_vs`
#. Select **Security** then **Policy** tab
#. Change **Application Security Policy** to :guilabel:`waf_baseCredentials`
#. Enable **Anti-Fraud Profile** and select :guilabel:`protect_credentials`
#. Click **Update**

   .. image:: ./images/image349.png
     :height: 300px

**Task 6 - Repeat simulated credential attacks**

#. Open browser and go to :guilabel:`https://<Elastic IP>/user/login`
#. For **Username** enter :guilabel:`f5student`
#. For **Password** enter random incorrect password.  Repeat multiple times using different password to simulate brute force attack.  You should receive a captcha challenge after 3 failed attempts.
#. Enter **captcha challenge** then enter correct credentials to login in successfully.
#. Open new **incognito browser** and open **developer tools**. (View->Developer-Developer Tools)
#. Browse to :guilabel:`https://<Elastic IP>/user/login` and login with **username** :guilabel:`f5student` and **password** :guilabel:`password`
#. Once successfully logged in, review log on **Developer Tool**.

   - Select :guilabel:`Network` tab
   - Highlight :guilabel:`login?return_url=`
   - On right panel click :guilabel:`Headers` and scroll to bottom of **Form Data** to view **Username** and **Password**.

   .. image:: ./images/image355.png
     :height: 300px
