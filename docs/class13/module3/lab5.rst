Convert an existing config to AS3 using the F5 VS Code Extension
================================================================================

Import a Qkview File
--------------------------------------------------------------------------------

#. Select the **F5** icon in the left navigation panel.

   .. image:: ./images/icon_F5Extension_inactive.png
      :align: left

   |

#. In the lower left part of the screen, select **Import.conf/UCS/QKVIEW from local file**.

   .. image:: ./images/5_vscode_openqkviewbutton.png
      :alt: Open qkview button
      :align: left
      :width: 90%

   |

#. In the toolbar that appears, navigate to the **/home/f5admin/f5lab/ATC/f5extension** directory. Select the qkview file.

   .. image:: ./images/6_vscode_openqkview_file.png
      :alt: Open qkview file
      :align: left
      :width: 90%

   |

#. It will take a little while to ingest the file and read it. When it is done, you will see the machine name of the device and a tree structure below it.

   .. image:: ./images/03f5ext_importcomplete.png
      :alt: qkview Import completed

   |

#. **Optional** Secondary way to open a qkview/ucs/.conf file.  In the **Explorer** view, you can right click on the qkview file and select **Explore TMOS Config**.

   .. image:: ./images/03f5ext_qkviewImport2.png
      :width: 90%

|

Explore a qkview with the F5 VS Code Extension
--------------------------------------------------------------------------------

Lets take a quick tour of what you can see in the config explorer.

- The first item under the **Config Explorer** is the name of the system that generated the qkview.

- **XC Diagnostics** is disabled by default.  Enabling this allows you to determine the readiness to migrate the configuration elements into F5's SaaS offering.

- **Sources** all of the conf files from the device.

- **Partitions** all of the partitions and the virtual servers/apps.

The remaining menu items can be explored later.


Convert an application/virtual server into an AS3 Declaration
--------------------------------------------------------------------------------

#. Expand the **Partitions**, then expand **Common** and search for **ITWiki3.0**.

   #. Select the application and then select all of the text in the window.

   #. Right click and select **Convert to AS3 with ACC**.

      .. image:: ./images/03f5ext_convertas3.png
         :alt: Convert itwiki3

     |

#. A new window will open with your new AS3 declaration that will replicate that configuration.

      .. image:: ./images/03f5ext_convertas3_result.png
         :alt: AS3 output

