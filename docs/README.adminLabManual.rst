Task 1 - Create AWS User and generate Access key ID and Secret Access key.
---------------------------------------------------------------------------

1. From the AWS Console -> Services -> Security, Identity & Compliance ->  IAM -> Users -> "Add user"

2. Check to enable Access type* : Programmatic access

3. Attach existing policies directly : AdministratorAccess.

.. note:: You almost certainly don't need AdministratorAccess. We'll lock down permissions in a future revision once I work out the minimum.

4. "Next: Review"

5. "Create user"

6. Copy and save the Access key Id and Secret access key to a file named "config" using the template below. Substitute $AWS_SECRET_ACCESS_KEY and $AWS_ACCESS_KEY_ID for the keys generated.

.. code-block:: bash

   [default]
   aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
   region = us-east-1
   aws_access_key_id = $AWS_ACCESS_KEY_ID

For example:

.. code-block:: bash

   [default]
   aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
   region = us-east-1
   aws_access_key_id = $AWS_ACCESS_KEY_ID

becomes...

.. code-block:: bash

   [default]
   aws_secret_access_key = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   region = us-east-1
   aws_access_key_id = XXXXXXXXXXXXXXXXXXXX
              

Task 2 - Encrypt config file, upload to an S3 bucket and apply source IP address access restrictions.
-----------------------------------------------------------------------------------------------------

1. Encrypt config with openssl. The command below was tested and works well with the f5-super-netops container:

.. code-block:: bash

   apk add openssl
   openssl aes-256-cbc -a -salt -in ./config -out ./config.esc

Enter and verify the password when prompted. Note the password. This will be the Decryption Password shared with lab students.

2. Upload config.esc to an S3 bucket. Select config.esc in the list under the Objects tab. Note the Link value to the right: https://s3.amazonaws.com/[BucketName]/config.enc

3. Click on the 'Permissions' tab above. => Select 'Bucket Policy'. => In the 'Bucket policy editor' edit the security policy based on the template below to reflect the IP addresses that will be accessing the lab.

.. code-block:: json

   {
       "Version": "2012-10-17",
       "Statement": [
           {
               "Sid": "IPDeny",
               "Effect": "Deny",
               "Principal": {
                   "AWS": "*"
               },
               "Action": "s3:*",
               "Resource": "arn:aws:s3:::f5-marfil/config.enc",
               "Condition": {
                   "NotIpAddress": {
                       "aws:SourceIp": [
                           "50.205.70.160/27",
                           "70.88.209.24/29",
                       ]
                   }
               }
           }
       ]
   }

Click Save.

4. From your s3 bucket, click on 'config.enc' and click on the download Link from a permitted IP address and confirm the file downloads. Open as text and verify it's encrypted.

5. Edit the s3bucket value in f5-super-netops-install.sh with the URL path to the s3 bucket. For example:

.. code-block:: bash

   s3bucket=https://s3.amazonaws.com/f5-marfil/

Task 3 - Generate evaluation Big-IQ licenses
--------------------------------------------

1. Generate an evaluation Big-IQ license: F5-BIQ-VE-MAX-LIC

2. Generate enough pool licenses to accomodate the class: F5-BIG-VEP3-25M-4V13-LIC