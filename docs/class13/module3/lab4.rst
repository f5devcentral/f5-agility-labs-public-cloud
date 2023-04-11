Using the F5 Extension to deploy applications and update ATC components
================================================================================


Connecting to your BIG-IP Devices
--------------------------------------------------------------------------------
Select `Add Host` in the `F5: Hosts` view.  Then type in device details in the \<user\>@x.x.x.x format, hit `Enter` to submit

 .. image:: ./images/addDeviceConnect_11.04.2020.gif
   :alt: Animated GUI
   :align: left
   :width: 80%

In the VSCode window that you have run all of your Terraform, copy the password used for your BIG-IP devices.
In the vscode window with the F5 Extension, click on the Host you just configured.  This will open a dialogue for the password.
**Create a device and connect**

.. note::
  DO NOT USE the right mouse button to paste the passowrd, this will cause the password dialog box to go 
  away and you will have to delete the host to get the opportunity to enter the pasword again.

Repeat this for the other BIG-IP.


Deploy AS3 configuration
-------------------------------------------------------------------------------
Make sure you are connected to BIG-IP1.  
Go to the Management GUI on BIG-IP1 notice it is set to Standby. Leave it that way for now.
Switch to the file view in VSCode.
Navigate to the ATC/AS3 directory.

Basic deployment with Autodiscovery

HA deployment

HA deployment wih modern protocols

HTTPS deployment that uses ECDSA certificates


Test application access
--------------------------------------------------------------------------------
Placeholder



Updating F5 Automation Toolchain Extensions
--------------------------------------------------------------------------------








