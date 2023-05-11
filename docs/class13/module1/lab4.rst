Download the Lab Files and Setup Environment
================================================================================

#. Switch to the **VS Code** terminal and clone the GitHub **f5jason/f5agilitylabs-big-ip-ha-public-cloud-terraform** repository. This repository contains additional files that are reqired for the lab exercises.

   .. code-block:: bash

      git clone https://github.com/f5jason/f5agilitylabs-big-ip-ha-public-cloud-terraform.git ~/f5lab


   You should see output similar to the following:

   .. code-block:: bash

      Cloning into '/home/f5admin/f5lab'...
      remote: Enumerating objects: 500, done.
      remote: Counting objects: 100% (232/232), done.
      remote: Compressing objects: 100% (66/66), done.
      remote: Total 500 (delta 182), reused 185 (delta 165), pack-reused 268
      Receiving objects: 100% (500/500), 93.44 MiB | 2.94 MiB/s, done.
      Resolving deltas: 100% (275/275), done.
      Updating files: 100% (68/68), done.

   |

#. Change to the repo directory and run the setup script. This script creates environment variables and shell command aliases that you will use later on.

   .. code-block:: bash

      cd ~/f5lab
      source ./setup.sh

|

This is the end of the module.
