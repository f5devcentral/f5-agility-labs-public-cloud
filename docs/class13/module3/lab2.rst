F5 Extensions for VS Code
================================================================================


Overview of the F5 Extension
--------------------------------------------------------------------------------

The F5 Extension simplifies development of F5 Automation Toolchain declarations by providing snippets, examples, and declaration validation. It also assists with connecting, deploying, retrieving, converting, and updating declarations on F5 devices.

Here are some example tasks that you can perform:

- Send API calls for all ATC services (DO, AS3, TS, CFE, FAST)
- Provides links to related ATC documentation and examples from the Github repository
- Install/unInstall of ATC packages
- Convert JSON <-> YAML
- View decoded information for base64 formatted certificates
- Extract application configurations (per virtual server)
- Write, deploy, and modify iRules/iApps (with vscode-irule extension for language support)


For more information, see |vscode_f5_extension|.

|

Install "F5 Extension" and "F5 ACC Chariot" Extensions
--------------------------------------------------------------------------------

#. Switch back to VS Code window that shows your Terraform folder.

#. Navigate to the **Extensions** menu. You may either click on the **Extensions** icon or use the **<CTRL-SHIFT-X>** keyboard shortcut.

   .. image:: ./images/icon_VS CodeExtensions_inactive.png
      :scale: 50%
      :align: left
      :alt: VS Code Extensions icon

   |

#. Type ``F5`` in the search box and then select **The F5 Extension**.

   .. image:: ./images/installWithinCode_11.04.2020.gif
      :alt: Animated GUI
      :align: left
      :width: 90%

   |

#. In the extension description panel (to the right of the search results), click on the **Install** button.

   .. image:: ./images/2_vscode_f5extinstall.png
      :alt: F5 Extension Installing
      :align: left
      :width: 90%

   |

#. In the list of extensions, you will also see **F5 ACC Chariot**. Select it and click on the **Install** button.

   .. image:: ./images/2_vscode_ACCExtensioninstall.png
      :alt: F5 ACC Installing
      :align: left
      :width: 90%



.. |vscode_f5_extension| raw:: html

   <a href="https://f5devcentral.github.io/vscode-f5/" target="_blank"> F5 VS Code Extension documentation </a>
