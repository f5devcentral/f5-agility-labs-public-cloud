Connecting to the Lab
----------------------

.. important:: Your student account, and short URL path will be announced at the start of the lab.

- Though the environment runs on a shared AWS account, every student will build and work in a dedicated AWS VPC.
- For this lab, a Ravello Windows 10 remote desktop jump host will be provided as a consistent starting point.

See :ref:`Connecting to the Lab Environment` for directions on connecting to the lab environment.

You may find it easier to follow this lab by opening this document in web browser to ease the process of copy and pasting text.

Lab Variables
-------------

The lab will make use of unique variables to provide access to the lab and isolate student environments.

============== ===========================================================
Variable Name   Variable Value
============== ===========================================================
 shortUrl       Unique Key that provides access to this lab (i.e. abc123)
 emailid        Account name for each student (i.e. user01@f5demo.com)
============== ===========================================================

Run Docker
-------------

From your open Putty Window in your Windows jumphost, launch the f5-super-netops docker container.

Cut and past the command below to accomplish the steps above.

.. code-block:: bash

   docker run -p 8080:80 -p 2222:22 -it -e SNOPS_AUTOCLONE=0 f5devcentral/f5-super-netops-container:base

This command will launch  in interactive mode, map port 22 on the container with 2222 on the host, and port 80 on the container with 8080 on the host.

You should see the resulting screen.

.. image:: /_static/snops-launched.png
  :scale: 50%

Set Variables
--------------

The following will store the lab variables that will be used later in the lab.

Export your student account and short URL path variables.
Your student account will be used to create an AWS console login and provide unique names for infrastructure that you create in the shared account. The short URL path will be used to grant access to the shared AWS account both via the AWS API and as the password for the AWS web console. Replace the emailid and shortUrl values below with the student account name and short URL assigned to you at the start of the lab.

Copy and paste the commands below to accomplish the steps above (replacing the example values with the values provided by your instructor).

.. code-block:: shell

   export emailid=user01@f5demo.com
   export shortUrl=abc123
   printenv

The ``printenv`` command will echo all your environment variables.  Look for emailid and shortUrl. Confirm the exported variables are correct.

Initialize your Lab Environment
-------------------------------

This will create an AWS credential that you will use to access the shared AWS account.

You will (instructions provided below)

- Change to your home directory.
- Clone the git repository for this lab.
- Change to the working directory.
- Run the start script.

Copy and paste the commands below to accomplish the steps above.

.. code-block:: bash

   cd ~
   git clone https://github.com/TonyMarfil/marfil-f5-terraform
   cd ~/marfil-f5-terraform/
   source start

.. attention::

  For a smooth ride, always invoke commands from inside the cloned git repository (marfil-f5-terraform). To check you're in the right place you can run the command ``pwd`` and the output should read ``/root/marfil-f5-terraform``

Launch Terraform
-----------------

Now that we have created credentials to access the AWS account we will use Terraform to deploy our lab environment.

Invoke terraform.

.. code-block:: bash

   terraform plan

This will output the changes that terraform will apply.  Now run.

.. code-block:: bash

   terraform apply

Once "terraform apply" completes, you can test your web server instances and ELB are up:

.. code-block:: bash

   curl -I `terraform output elb_dns_name`

You should see a reply with status code "HTTP/1.1 200 OK". Hit <ctrl>+C to stop.

When 'terraform apply' completes, note the \*\*aws_alias\*\* and vpc-id values. Open up your \*\*aws_alias\*\* link in a browser and login to the AWS console with the email address and password you created during the install. You can always get these values by invoking terraform output with the variable name:

.. code-block:: bash

   terraform output **aws_alias**
   terraform output vpc-id

.. warning:: terraform apply will take five minutes to complete, but the environment will not be ready for another 15 minutes as the Big-IP virtual editions and supporting infrastructure wake up. In the meantime, we can begin to explore the AWS lab environment.

What just happened? That was a lot of random text scrolling in my Docker console!
---------------------------------------------------------------------------------

This is the TL;DR version of the steps completed.

When you clone the git repository, you are pulling down a fresh copy of the all of the files you need to get started. These files are hosted on Github, the most popular online revision control repository, and include:

- Onboarding scripts that create your AWS account and other prerequisites: *f5-super-netops-install.sh*, *addUser.sh*, *export.sh*.
- all of the terraform configuration files--a declarative, comprehensive representation of our entire application stack:

	*main.tf* - Every terraform configuration has a main.tf. This contains all of the AWS specific (non-F5) environment configuration, including web instances

	*f5-cloudformation-autoscale-waf.tf* and *f5-cloudformation-cross-az-ha-hourly.tf* - Nothing more than a terraform file that takes the officially supported CloudFormation template hosted at:

	https://s3.amazonaws.com/f5-cft/f5-autoscale-bigip.template

	https://s3.amazonaws.com/f5-cft/f5-existing-stack-across-az-cluster-hourly-2nic-bigip.template

	...and stuffs all of the prerequisite parameters so we don't have to do it manually.

	*outputs.tf* - Any variable in the outputs.tf file can be rendered to the console with 'terraform output' and is exposed to other command line tools.

	*vars.tf* - Variables for terraform.

- Handy utilities to help move the lab along with minimum fuss: *lab-info*, *password-reset*, *lab-cleanup*.

The start script takes care of all of the prerequisites to standing up an AWS environment. Precisely:

- Installs all of the necessary software, including: terraform, the aws cli, and various other command line tools.
- Creates your AWS console login and api account and stores the keys locally for use by the AWS command line.
- Creates SSH keys for use by all of your EC2 instances: web servers and Big-IP virtual editions.
- Creates a self-signed SSL certificate for use in deploying https services.
- Sets the default region: us-east-1 (Virginia), ap-southeast-1 (Singapore), etc.

The terraform files go into effect when you invoke 'terraform apply'. This step makes use of all of the prerequisites from the step before to build the environment in AWS.

Video example
-------------
This video_ walks through all of the steps in this part of the lab. The emailid and shortUrl values used are only examples and no longer valid. You can pause, cut, and paste from the example, but always remember to replace the example values with the values assigned to you by the lab instructor.

.. _video: https://asciinema.org/a/Tj8vreWGmvXBT7dGhqv36RFMg
