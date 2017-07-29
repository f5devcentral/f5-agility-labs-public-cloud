Nuke environment
----------------
1.  AWS Console => Services => Storage => S3. Use your user account to filter for your S3 buckets. For example: 'user01'. Delete your two S3 buckets prefaced with ha- and waf-.

2. AWS Console => Services => Compute => EC2. Auto Scaling Groups. Use same filter as above.

3. Click on 'Instances' tab below. Select your Instances. Actions => Instance Protection => Remove Scale In Protection from any instances that are protected.

4. From the f5-super-netops terminal:

.. code-block:: bash

   terraform destroy

   Do you really want to destroy?
     Terraform will delete all your managed infrastructure.
     There is no undo. Only 'yes' will be accepted to confirm.

     Enter a value: yes

   var.bigiqLicenseManager
     Management IP address of the BigIQ License Manager

     Enter a value: null

Answer 'yes' and 'null' when prompted.

5. The end.

.. note:: Many thanks to Yevgeniy Brikman for his excellent *Terraform: Up and Running: Writing Infrastructure as Code 1st Edition* that helped me get started. http://shop.oreilly.com/product/0636920061939.dos
