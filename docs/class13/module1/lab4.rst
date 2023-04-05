Download the Lab Files and Setup Environment
================================================================================

Switch to the VS Code **BASH terminal** and clone the GitHub **f5jason/f5agilitylabs-big-ip-ha-public-cloud-terraform** repository. This repository contains additional files that are reqired for the lab exercises.

   .. code-block:: bash

      git clone https://github.com/f5jason/f5agilitylabs-big-ip-ha-public-cloud-terraform.git ~/f5lab


You should see output similar to the following:

   .. code-block:: bash

      f5admin@JUMPHOST:~$ git clone https://github.com/f5jason/f5agilitylabs-big-ip-ha-public-cloud-terraform.git ~/f5lab
      Cloning into '/home/f5admin/f5lab'...
      remote: Enumerating objects: 76, done.
      remote: Counting objects: 100% (41/41), done.
      remote: Compressing objects: 100% (37/37), done.
      remote: Total 76 (delta 6), reused 26 (delta 3), pack-reused 35
      Unpacking objects: 100% (76/76), 35.08 KiB | 7.00 KiB/s, done.

|

Change to the repo directory and run the ``setup.sh`` script. This script creates environment variables and shell command aliases that you will use later on.

  .. code-block:: bash

     cd ~/f5lab
     source ./setup.sh

|

This is the end of the module.
