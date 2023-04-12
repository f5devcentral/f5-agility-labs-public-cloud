Download the Lab Files and Setup Environment
================================================================================

Switch to the VS Code **BASH terminal** and clone the GitHub **f5jason/f5agilitylabs-big-ip-ha-public-cloud-terraform** repository. This repository contains additional files that are reqired for the lab exercises.

   .. code-block:: bash

      git clone https://github.com/f5jason/f5agilitylabs-big-ip-ha-public-cloud-terraform.git ~/f5lab


You should see output similar to the following:

   .. code-block:: bash

      Cloning into '/home/f5admin/f5lab'...
      remote: Enumerating objects: 404, done.
      remote: Counting objects: 100% (369/369), done.
      remote: Compressing objects: 100% (208/208), done.
      remote: Total 404 (delta 207), reused 288 (delta 149), pack-reused 35
      Receiving objects: 100% (404/404), 93.43 MiB | 5.07 MiB/s, done.
      Resolving deltas: 100% (214/214), done.
      Updating files: 100% (61/61), done.

|

Change to the repo directory and run the setup script. This script creates environment variables and shell command aliases that you will use later on.

  .. code-block:: bash

     cd ~/f5lab
     source ./setup.sh

|

This is the end of the module.
