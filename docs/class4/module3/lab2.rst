Create WAF Parent Policy
------------------------
**Task 1 - Create a parent waf policy using info on table below:**

.. list-table::
    :widths: 20 40
    :header-rows: 0
    :stub-columns: 0

    * - **Policy Name**
      - waf_Base
    * - **Policy Type**
      - Parent
    * - **Policy Template**
      - Rapid Deployment Policy
    * - **Learning Mode**
      - manual
    * - **Signature Staging**
      - Disabled


#. Select the **Security->Application Security->Security Policies->Policies List** page
#. Click **Create New Policy**
#. Select **Advanced** options

   .. image:: ./images/image308.png
     :height: 30px

#. For **Policy Name** enter :guilabel:`waf_base`
#. For **Policy Type** select :guilabel:`Parent`
#. For **Policy Template** select :guilabel:`Rapid Deployment Policy`
#. For **Learning Mode** select :guilabel:`Manual`
#. Change **Signature Staging** to :guilabel:`Disabled`

   .. image:: ./images/image309.png
     :height: 400px

#. Click **Create Policy**
#. Once the policy is created, with the :guilabel:`waf_base` policy selected, in the right panel click **Inheritance Settings**.
#. Configure the **inheritance settings** as shown on the image below, and then click **Save Changes**

   .. image:: ./images/image310.png
     :height: 400px

.. NOTE::
   Beginning in BIG-IP ASM 13.0.0, you can create a parent security policy and
   have child security policies refer to it (layered policies). A parent security
   policy defines common Policy Section elements and settings that provide baseline
   protection for your environment and are inherited by all child policies attached
   to it. You identify the elements and settings that can be modified in child
   security policies and those that are mandatory and cannot be modified. When
   you modify elements and settings in the parent security policy, the system
   rapidly applies them to all attached child policies.
