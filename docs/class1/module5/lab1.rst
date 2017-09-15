Run the lab on your own
-----------------------

You can run this lab on your own, on any AWS account, but you will need to create your own admin account and tweak the startup steps slightly.

#. Login to your AWS account and create an admin user and access keys.
#. Services -> Security, Identity & Compliance -> IAM -> Groups -> Create New Group. Name this group "terraform-admin" Attach Policy: AdministratorAccess.
#. Services -> Security, Identity & Compliance -> IAM -> Groups -> Create New Group. Name this group "terraform-lab-user" Attach Policy: AdministratorAccess.
#. Services -> Security, Identity & Compliance -> IAM -> Users -> Create New User. Name this user "terraform-lab-admin".
#. Access type: "Programmatic access" only. Click "Next: Permissions."
#. Add user to group: terraform-admin. click "Next: Review."
#. Click "Create user"
#. Copy the Access key ID and Secret access key before clicking "Close." You will need both of these keys to configure the AWS command line tool.


.. attention::
  
  The emailid and shortUrl environment variables must still be exported, but they can be anything you want. emailid must be in valid email format, but does not have to be a real email address that can be validated.

.. attention::
  
  Do not initialize your lab environment as shown for students in a coordinated F5 lab session. Replace **2.1.5. Initialize your Lab Environment** with the steps below.

- Change to your home directory.
- Clone the git repository for this lab.
- Change to the working directory.
- **Install and configure aws cli with admin keys previously created, region and output format.**
- Run the start script.

Copy and paste the commands below to accomplish the steps above.

.. code-block:: bash

   cd ~
   git clone https://github.com/TonyMarfil/marfil-f5-terraform
   cd ~/marfil-f5-terraform/
   pip install --upgrade --user awscli
   export PATH=~/.local/bin:$PATH
   export AWS_CONFIG_FILE=~/.aws/config
   aws configure
   
Example output below:

.. code-block:: bash

   #aws configure
   AWS Access Key ID [None]: XXXXXXXXXXXXXXXXXXXX
   AWS Secret Access Key [None]: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   Default region name [None]: us-east-1
   Default output format [None]: json

.. code-block:: bash
   
   source start

.. attention::

  For a smooth ride, always invoke commands from inside the cloned git repository (marfil-f5-terraform). To check you're in the right place you can run the command ``pwd`` and the output should read ``/root/marfil-f5-terraform``

Pick up the lab in the next section **2.1.6 Launch Terraform.**