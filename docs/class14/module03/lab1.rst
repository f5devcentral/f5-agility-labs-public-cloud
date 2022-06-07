Prepare F5 VSCode Extension
===========================

The rest of the lab we will be working with the F5 Automation Toolchain. This
is a set of declarative API endpoints that you can install on top of TMOS to
allow you to more simply manage BIG-IPs through an API. As part of the upcoming
GCP Terraform module, these modules will be installed by default. Navigate in
the TMUI to "iApps -> Package management LX" and you'll see four packages (The
fifth is Service Discovery and is now a subset of AS3):

.. image:: ./images/TMUI_ATCCheck.png
   :scale: 50%
   :alt: Select F5

The terraform apply you performed in the last step generated the necessary
declaration files for rest of the lab. They are located under the
f5-agility_GCP_Terraform_ATC folder.

The first step will be to configure the F5 VS Code Plugin to connect to the two
BIG-IPs

.. image:: ./images/01_select_F5.png
   :scale: 50%
   :alt: Select F5

Copy bigip_1_host information then click on add host then paste and enter.

.. image:: ./images/03_add_first_host.png
   :scale: 50%
   :alt: Add BIG-IP1

Once the name loads on the side column click on the host and paste in the
bigip_password.

.. image:: ./images/04_double_click_pwd.png
   :scale: 50%
   :alt: BIG-IP1 Password

Do the same for big-ip 2.

.. note:: Make sure you are signed into BIG-IP Host 1 for the next step. Click
   the bottom blue bar where it says DO(1.18.0). This will open separate window
   with status is 200 OK and the Body response will indicate the DO version.

Submit Declarative Onboarding declarations
------------------------------------------

From f5-agility_GCP_Terraform_ATC click on Lab4.1-DO under the drop down menu,
select "do_BIGIP1.json" request.

.. image:: ./images/05_select_DO_step1.png
   :scale: 50%
   :alt: Add BIG-IP1

Make sure that your "target" is BIG-IP1:

.. image:: ./images/06_check_target_BIGIP.png
   :scale: 50%
   :alt: BIG-IP1 target

Right Click "Post as DO Declaration". The Status will return as "202 RUNNING."

.. image:: ./images/07_post_as_DO.png
   :scale: 50%
   :alt: Post DO

.. image:: ./images/08_DO_progress.png
   :scale: 50%
   :alt: Post DO

Check the status of DO by ckicking on the DO(1.18.0) in the blue bar at the
bottom.

.. image:: ./images/09_DO_refresh_status.png
   :scale: 50%
   :alt: Add BIG-IP1

Wait a few minutes until status is 200 OK

.. image:: ./images/15_do2_complete.png
   :scale: 50%
   :alt: Add BIG-IP1

At the bottom of the VS Code window in the blue bar, you can click on the DO
(1.18.0) to submit a "GET" request to get the status of the DO execution as you
did above. Wait until you get a status of "200 OK."

Now sign into BIG-IP Host 2 by clicking on the F5 Plugin and left clicking on
the second BIG-IP. Click on Lab4.1-DO under the drop down menu, select
"do_step2.json" request. Right Click "Post as DO Declaration".

.. image:: ./images/15_do2.png
   :scale: 50%
   :alt: Add BIG-IP1

Wait a few minutes until status is 200 OK

.. image:: ./images/15_do2_complete.png
   :scale: 50%
   :alt: Add BIG-IP1
