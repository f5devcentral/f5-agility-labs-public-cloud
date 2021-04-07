Login to F5's lab platform (Unified Demo Framework) and launch a remote desktop session
=======================================================================================

Follow the link in your email invite and login to the lab environment.

Your Deployment => Systems => Client => VS Code.

.. image:: ./images/00_admin_pass.png
  :scale: 50%

Click [Done] in the lower right-hand corner.

Under win2019, from the ACCESS drop-down, select RDP and resolution. The lab looks best in FHD (1920 x 1080). This will download the rdp file to your computer. Launch the RDP file and login via RDP using the Administrator credentials. Copy and paste credentials from your clipboard.

.. image:: ./images/01_rdp.png
  :scale: 50%

### Clone github repository to VS Code

### Authenticate 'gcloud' command line utility - must be the same user you signed up for Agility with and _must_ be a Google Account.



Deploy F5 Virtual Editions and a complete application environment to GCP with Terraform
=======================================================================================

From the Visual Studio Code Terminal, clone the github repository for this lab and change to the working directory.

.. attention::

  For a smooth ride, always invoke commands from inside the cloned git repository (f5agility2020-pc201). To check you're in the right place, you can run the command ``pwd`` and the output should read ``/home/f5admin/f5agility2020-pc201``

.. code-block:: bash

   git clone https://github.com/jtylershaw/Agility2021_GCP_Terraform_ATC.git
   cd Agility2021_GCP_Terraform_ATC/

.. image:: ./images/9_vscode_git_clone.png
  :scale: 50%



### terraform init
### terraform plan
### terraform apply

You can always get the `terraform output` values again by invoking from the terminal, make sure to have bash toggled:

.. code-block:: bash

   terraform output

.. image:: ./images/14_bash.png
  :scale: 50%



Login to GCP Console
====================

Click on "Firefox" under access methods (or use your own local browser if able) and navigate to https://console.cloud.google.com with the e-mail address that you signed up for Agility with, and you just signed in to authenticate with 'gcloud.'

Once your terraform apply has finished, navigate to "Compute Engine" -> "VM Instances" and locate your BIG-IP instances denoted by "studentX-Y-YYYY-f5vm0[1,2]."  These are your BIG-IP units running within GCP





Change

.. attention::

  We will be returning to lecture at this point of the lab.  We will allow the BIG-IPs to start up for all students during the lecture.