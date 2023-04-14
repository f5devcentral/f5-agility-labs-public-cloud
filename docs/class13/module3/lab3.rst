Connecting the F5 Extension to your devices and verifying the state of AS3
================================================================================


Connecting to your BIG-IP Devices
--------------------------------------------------------------------------------


#. Just under the ``VSCode`` icon in the upper left corner is the explore icon, select this and navigate to the ``/ATC/f5extension`` directory. Open the ``devices.json`` file.

    .. image:: ./images/icon_VSCodeExplorer_inactive.png
       :align: left
       :scale: 50%
       :alt: VSCode Explorer icon

    .. image:: ./images/1f5Extension_deviceimport.png
       :scale: 90%
       :align: left
       :alt: Directory image

#. Highlight all of the text in the json file.


    .. code-block:: json
   
        [
            {
                "device": "admin@52.11.43.7",
                "password": "Kr6g0txUkbusgkAY"
            },
            {
                "device": "admin@52.41.210.58",
                "password": "Kr6g0txUkbusgkAY"
            }
        ]


    .. image:: ./images/2f5Extension_deviceimport.png
       :scale: 90%
       :alt: Directory image

#. Then right click or cmd click on the highlighted text.  Select ``Import Devices``.

    .. image:: ./images/3f5Extension_deviceimport.png
       :scale: 90%
       :alt: Directory image


#. We are using this file to import multiple devices all at once, including the passwords.  This can also be done without the passwords, so that you would have to add the passwords manually when connecting.

#. Select the ``F5`` icon in the left navigation menu.  Connect to each of the BIG-IP hosts.  Notice that upon successful connection that there is a hexagon with an F5 in the middle.

    .. image:: ./images/icon_F5Extension_inactive.png
       :scale: 50%       
       :align: left
       :alt: F5 extension icon

    .. image:: ./images/4f5Extension_deviceconnect.png
       :alt: Connected devices
       :align: left


Verify AS3 state on each device
-------------------------------------------------------------------------------

When the ``F5 Extension`` connects to a device it runs a series of queries to give you quick access to a variety of 
information.  In the status bar at the bottom of the VScode window, you can see the elements of the ATC that are installed.


#. You can click on this text to get some updates from the system.

   .. image:: ./images/5f5Extension_statusbar.png
      :alt: VSCode status bar with arrow pointing to AS3 version

#. Here you can see that the Terraform build out process installed four of the five components of the ATC, AS3, DO, TS, and CFE.

#. Next we will issue a rest call to the AS3 listener to ensure it is functioning.  For this we will use a feature of the F5 Extension called ``Make HTTP Request`` available in the context menu.

#. Ensure you are connected to ``BIG-IP1``, then navigate to ``/ATC/AS3``and open ``as3check_makehttprequest.json``.


   .. code-block:: json
        {
            "url": "/mgmt/shared/appsvcs/info"
        }


    .. image:: ./images/6f5Extension_makehttprequest.png
       :alt: Showing the location of the file to open

#. Select all of the text of the JSON file and right click on the text.  This opens the context menu where you can select ``Make HTTP Request``.

    .. image:: ./images/7f5Extension_makehttprequest.png
       :alt: context menu 

#. Once the response has been received, it will appear in a new panel.  You should see that the version returned matches the version number in the statusbar.

    .. image:: ./images/8f5Extension_makehttprequest.png
       :alt: Response windows

#. Connect to ``BIG-IP2`` and repeat the steps above.
 
