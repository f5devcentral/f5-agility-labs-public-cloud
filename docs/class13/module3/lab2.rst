Install The F5 Extension and the F5 ACC Chariot extension
================================================================================
In VSCode, navigate to the Extensions menu.  You may either press the Extensions icon or use the CTL + Shift + X shortcut.
Search for F5, select the extension “The F5 Extension”, then Install.

.. image:: ./images/installWithinCode_11.04.2020.gif
   :alt: Animated GUI
   :align: left
   :width: 80%

In the list of extensions related to F5, you should also see F5 ACC Chariot, click Install.

Overview of the F5 Extension
--------------------------------------------------------------------------------

Enhance your abilities to write (A)utomated (T)ool(C)hain declarations with snippets, examples and declaration 
schema validation, and also assist with connecting, deploying, retrieving and updating declarations on F5 devices.

It can also help with iRules/iApps, BIG-IQ, and regular configuration/migration .

- GET/POST/DELETE of all ATC services, including FAST/AS3/DO/TS/CF
- links to quickly open related ATC documentation
- Direct access to ATC examples from git repo
- Install/UnInstall of ATC rpms
- Convert JSON <-> YAML
- Hovers to view decoded information for (certificates/base64)
- Extract TMOS applications (per virtual server)
- Write, deploy and modify iRules/iApps (with vscode-irule extension for language support)

**GUI Essentials**
On the left hand tool bar/menu, select/click on the F5 logo.  This will launch the F5 Extension.
You should see three panels on the left, one for BIG-IP Hosts, Documentation/Examples, and Config Explorer.



Examine a qkview of an existing device 
--------------------------------------------------------------------------------

First we need to move the qkview file from the WSL system to your desktop.  In the terminal window in VSCode, execute the command below:

   .. code-block:: bash

      cp ~/f5lab/ATC/f5extension/* /mnt/c/Users/user/Desktop/






Use VS Code F5 Extension to convert a configuration to AS3 format
--------------------------------------------------------------------------------
Placeholder



Review AS3 declaration
================================================================================
Placeholder



