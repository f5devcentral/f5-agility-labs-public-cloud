Terraform Destroy
-----------------

Delete the S3 bucket.

.. image:: ./images/1_aws_console_delete_s3_bucket_contents.png
	   :scale: 50%

.. image:: ./images/2_aws_console_delete_s3_bucket_contents2.png
	   :scale: 50%

.. code-block:: bash

   terraform destroy --force

.. image:: ./images/3_vscode_terraform_destroy.png
	   :scale: 50%

.. image:: ./images/4_vscode_terraform_destroy_complete.png
	   :scale: 50%

Confirm it's all gone.

.. image:: ./images/5_aws_console_ec2_clean.png
	   :scale: 50%

Fin.