Cleanup
-------

Delete the S3 bucket.

AWS => Services => S3 => delete bucket.

.. image:: ./images/1_delete_s3_bucket.png
	   :scale: 50%

Delete the CloudFormation Stack.

.. image:: ./images/2_delete_cloudformation_stack.png
	   :scale: 50%

Terraform destroy
-----------------

From the Visual Studio Code Terminal, invoke `terraform destroy`.

.. code-block:: bash

   terraform destroy --force -var 'bigip_admin_password=f5letme1n'

.. image:: ./images/3_terraform_destroy.png
	   :scale: 50%

.. image:: ./images/4_terraform_destroy_complete.png
	   :scale: 50%

Confirm it's all gone. Review AWS => Services => ec2 => Instances.

Fin