Download the Lab Files and Setup Environment
================================================================================

Switch to the VS Code **BASH terminal** and clone the GitHub **f5jason/f5agilitylabs-big-ip-ha-public-cloud-terraform** repository. This repository contains additional files that are reqired for the lab exercises.

   .. code-block:: bash

      git clone https://github.com/f5jason/f5agilitylabs-big-ip-ha-public-cloud-terraform.git ~/f5lab


You should see output similar to the following:

   .. code-block:: bash

      Cloning into '/home/f5admin/f5lab'...
      remote: Enumerating objects: 223, done.
      remote: Counting objects: 100% (188/188), done.
      remote: Compressing objects: 100% (96/96), done.
      remote: Total 223 (delta 102), reused 153 (delta 83), pack-reused 35
      Receiving objects: 100% (223/223), 93.40 MiB | 8.78 MiB/s, done.
      Resolving deltas: 100% (109/109), done.
      Updating files: 100% (55/55), done.

|

Change to the repo directory and run the setup script. This script creates environment variables and shell command aliases that you will use later on.

  .. code-block:: bash

     cd ~/f5lab
     source ./setup.sh

|

This is the end of the module.
