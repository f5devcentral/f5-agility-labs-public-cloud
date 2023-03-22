Access the Jump Host
================================================================================

If you are not familiar with the process for joining a training course, refer to:

- |join_link|
- |interface_link|

Your course registration email contains a link to the UDF course.


  .. image:: ./images/udf-email.png
     :align: left

Click on the link and log into the student portal with your UDF credentials. If you do not remember your password, click on the **Forgot your password?** link.

  .. image:: ./images/udf-login.png
     :align: left

After signing in, click on the **Join** button.

  .. image:: ./images/udf-join.png
     :align: left

After joining the course, you will see the **DOCUMENTATION** tab with some information about the lab resources and a link to the Lab Guide (this document).

  .. image:: ./images/udf-documentation.png
     :align: left

.. note::

   You will only need an RDP client to perform the lab exercises. SSH access to the lab environment is not required, so no SSH Key needs to be configured in UDF.

Click on the **DEPLOYMENT** tab to see all of your lab resources. You will only need to access the Windows jump host.

  .. image:: ./images/udf-deployment.png
     :align: left

Under **win2019**, click on the **ACCESS** drop-down menu.

  .. note::

     If you cannot click on the **ACCESS** button, then the jump host has not finished booting. Wait until you see a green triangle beside the resource name.

Click on a resolution to use for your RDP session. This lab is best experienced in 1920x1080 resolution. An RDP file will be downloaded to your computer.

Launch the RDP file and accept the warning prompts.

  .. image:: ./images/jumphost-1.png
     :align: left

At the login prompt (Windows RDP client app), click on **More choices**, then **Use a different account**.

Login using the following credentials:

  +------------+------+
  | Username:  | user |
  +------------+------+
  | Password:  | user |
  +------------+------+

(It's OK, this resource is only accessible through your authenticated UDF session.)

  .. image:: ./images/jumphost-2.png
     :align: left

Accept the next warning prompt.

  .. image:: ./images/jumphost-2b.png
     :align: left


When you see the **Networks** prompt, click **Yes** to continue.

  .. image:: ./images/jumphost-3.png
     :align: left

You should now see the Windows desktop with the following:

- AWS Console Sign-In shortcut
- BASH Terminal shortcut

The BASH Terminal window will launch automatically upon login. On first launch, it may take a minute to complete the startup script. When done, you will see the following information (some of which you will use later):

- Terraform environment variables
- AWS Console URL, Username ('udf'), and Password (*random*)
- Public IP address of the jump host
- Installed versions for AWS CLI, Terraform, and Ansible software

|

  .. image:: ./images/jumphost-4.png
     :align: left


.. note::

   The Windows jump host uses WSL (Windows Subsystem for Linux) to provide access to an Ubuntu Linux environment where Terraform and Ansible are installed.

   The UDF system automatically creates a temporary AWS cloud account for use in the lab. The credentials are displayed whenever you launch the BASH Terminal.

   If you attempt to run through parts of this lab in your own environment (i.e., not using UDF), you will need to export your own AWS credentials for Terraform to use.

Launch **Firefox** from the taskbar at the bottom of the desktop. The web browser will open to the **SSL Orchestrator 301 Lab Guide**. You might find it easier to use this copy of the guide for the rest of the lab.


.. |join_link| raw:: html

      <a href="https://help.udf.f5.com/en/articles/3832165-how-to-join-a-training-course" target="_blank"> How to join a training course </a>

.. |interface_link| raw:: html

      <a href="https://help.udf.f5.com/en/articles/3832340-training-course-interface" target="_blank"> How to use the training course interface </a>

