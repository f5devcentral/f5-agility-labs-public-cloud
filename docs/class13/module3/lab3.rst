Managing Devices with F5 VS Code Extension
================================================================================


Connect to your BIG-IP Devices
--------------------------------------------------------------------------------

#. Click on the file **Explorer** icon (top left corner - below the **VS Code** icon).


#. Navigate to the **/ATC/f5extension** folder and open the **devices.json** file.

   .. image:: ./images/icon_VS CodeExplorer_inactive.png
      :scale: 50%
      :align: left
      :alt: VS Code Explorer icon

   |

   .. image:: ./images/2f5Extension_deviceimport.png
      :alt: Directory image

   |

#. Highlight all of the text in the JSON file.

   .. code-block:: json

      [
          {
              "device": "admin@52.11.43.7",
              "password": "xxxxxxxxxxxxxxxx"
          },
          {
              "device": "admin@52.41.210.58",
              "password": "xxxxxxxxxxxxxxxx"
          }
      ]

   |

#. Right-click (MacOS: Command-click) on the highlighted text and select **Import Devices**.

   .. image:: ./images/3f5Extension_deviceimport.png
       :alt: Directory image

   |

   We are using this file to import multiple devices all at once, including the passwords.  This can also be done without the passwords, so that you would have to add the passwords manually when connecting.


#. Click on the **F5** icon in the left navigation menu to switch to the **F5 Extension**.

#. Click on each BIG-IP host to connect to it. Upon successful connection, you will see a hexagon with an F5 in the middle.

   .. image:: ./images/4f5Extension_deviceconnect.png
      :align: left
      :alt: Directory image

   |

#. The status bar at the bottom of the VS Code windows shows that the Terraform deployment installed the following ATC extensions: AS3, DO, TS, and CFE.

   .. image:: ./images/5f5Extension_statusbar.png
      :alt: VS Code status bar with arrow pointing to AS3 version

   |

   You can click on the ATC extension names to get updates.


Check AS3 Extension Status
--------------------------------------------------------------------------------

Now, we will issue a REST call to the AS3 API endpoint to ensure that it is functioning.  We will use a feature of the F5 Extension called **Make HTTP Request** available in the context menu.

#. Ensure you are connected to **BIG-IP #1**, then switch back to the **Explorer**.

#. Navigate to **/ATC/AS3** and open **as3check_makehttprequest.json**.

   .. image:: ./images/6f5Extension_makehttprequest.png
      :alt: Location of the file to open

   |

#. Select all of the text of the JSON file and then right click on the text to open the context menu.

#. Select **Make HTTP Request** to send the JSON as a request to **BIG-IP #1**.

   .. image:: ./images/7f5Extension_makehttprequest.png
      :alt: Context menu

   |

#. The response will appear in a new panel.  You should see that the version returned matches the version number in the status bar.

   .. image:: ./images/8f5Extension_makehttprequest.png
      :alt: Response windows

   |

#. Repeat the AS3 status check for **BIG-IP #2**.


.. attention::

   Don't forget to connect to **BIG-IP #2** in the **F5 Extension** panel first.
