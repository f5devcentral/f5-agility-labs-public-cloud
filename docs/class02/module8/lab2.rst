Create a Big-IQ Cloud Provider
------------------------------

From your Super-NetOps terminal, there are multiple ways to see your AWS access keys. You can echo the environment variables:

.. code-block:: bash

   echo $AWS_ACCESS_KEY_ID
   echo $AWS_SECRET_ACCESS_KEY

...or you can cat the hidden ~/.aws/config file:

.. code-block:: bash

   cat ~/.aws/config

Copy the aws_access_key_id to the clipboard.

.. image:: ./images/7_copy_aws_access_keys.png
  :scale: 50%

In Big-IQ, Applications => Environments => Cloud Providers => Create Cloud Provider.

- Name: aws
- Description: admin
- Provider Type: AWS

Fill in the "Access Key ID" and "Secret Access Key" and click [Test].

When your [Test] results in "Test Connection Successful" click on "Save & Close".

.. image:: ./images/8_test_access_keys.png
  :scale: 50%
  