Using the F5 Extension to Deploy AS3 declarations
===============================================================================

Make sure you are connected to BIG-IP1 in the F5 Extension.

#. Go to the Management GUI on BIG-IP1 notice it is set to ``Standby``. Leave it that way for now.

#. In the Management GUI, navigate to ``Local Traffic --> Virtual Servers`` and see that you only have two partions with no configuration.

    **BIG-IP1**

    .. image:: ./images/01as3_noconfig.png
        :alt: BIGIP management GUI no config
        :width: 95%

    **BIG-IP2**

    .. image:: ./images/01as3_noconfig_2.png
        :alt: BIGIP management GUI no config
        :width: 95%

#. Close the ``as3check_makehttprequest.json`` file.

#. Switch to the file view in ``VSCode``.

#. Navigate to the ``ATC/AS3`` directory.


Step1 Create HTTP Virtual Servers with AS3 and Service Discovery
--------------------------------------------------------------------------------


#. Open the ``ATC\AS3\Step1_as3_AWS_Autodiscovery.json`` file.  In the window with the JSON declaration, select all of the text.  If you scroll down a little bit you will see that we are telling AWS to look for tagged instances and add them to the pool.

    .. image:: ./images/02as3_step1a.png
        :alt: load JSON file
        :width: 80%


#. Select all of the text and then right click to select ``Post as AS3 Declaration``.

    .. image:: ./images/02as3_step1b.png
        :alt: POST as AS3 declaration
        :width: 80%

#. As the extension waits for confirmation that the declaration was correct and able to be processed, you will see this:

    .. image:: ./images/02as3_step1c.png
        :alt: Posting Declaration
        :width: 80%

#. Here you can see that all sections of the declaration were successful. Below the highlighted box is the declaration that you submitted.

    .. image:: ./images/02as3_step1_success.png
        :alt: Successful deployment
        :width: 80%

#. In the Management GUI for both BIG-IP devices, confirm the creation of:

     * A new partition/tenant
     * Pool was created and populated with two pool members
     * Pair of virtual servers were created

    **BIG-IP1**

    .. image:: ./images/02as3_step1verify1.png
        :alt: BIGIP management GUI partition verification
        :width: 80%

    .. image:: ./images/02as3_step1verify1pool.png
        :alt: BIGIP management GUI shared pool verification
        :width: 80%

    .. image:: ./images/02as3_step1verify1vs.png
        :alt: BIGIP management GUI VS verification
        :width: 80%

    **BIG-IP2**

    .. image:: ./images/02as3_step1verify2.png
        :alt: BIGIP management GUI partition verification
        :width: 80%

    .. image:: ./images/02as3_step1verify2pool.png
        :alt: BIGIP management GUI shared pool verification
        :width: 80%

    .. image:: ./images/02as3_step1verify2vs.png
        :alt: BIGIP management GUI VS verification
        :width: 80%


Step2 Enable modern protocols such as HTTP/2 with AS3 and Service Discovery
--------------------------------------------------------------------------------

#. Close the ``untitled`` panel

#. Close the ``Step1_as3_AWS_Autodiscovery.json`` file.

#. Open ``Step3_as3_HTTPS_Autodiscovery.json``, select all of the text and then right click to select ``POST as AS3 Declaration``.

    .. image:: ./images/02as3_step2a.png
        :alt: load JSON file
        :width: 80%

    .. image:: ./images/02as3_step2b.png
        :alt: POST as AS3 declaration
        :width: 80%

    .. image:: ./images/02as3_step1c.png
        :alt: Posting Declaration
        :width: 80%

#. When successful, the BIG-IP will return a ``200`` with a message of ``success``.

    .. image:: ./images/02as3_step2_success.png
        :alt: Successful deployment
        :width: 80%

#. In the Management GUI for both BIG-IP devices, confirm the creation of 

     * Pair of HTTPS virtual servers were created
     * Virtual servers have a http/2 profile attached

  
    .. image:: ./images/02as3_step2_vs.png
        :alt: BIGIP management GUI VS verification
        :width: 80%

    .. image:: ./images/02as3_step2_vshttp2.png
        :alt: BIGIP management GUI http2 verification
        :width: 80%

#. Verify connectivity to the HTTPS application and note the ciphers in use

     * Open you browser and in a new tab, navigate to the IP address ``vip1_public_ip``
     * Use developer tools to see the ciphers in use


    .. image:: ./images/02as3_step2_web.png
        :alt: BIGIP management GUI shared pool verification
        :width: 80%

    .. image:: ./images/developertools.png
        :alt: BIGIP management GUI shared pool verification
        :width: 50%

    .. image:: ./images/02as3_step2_Ciphers.png
        :alt: BIGIP management GUI VS verification
        :width: 50%



Step3 Adding ECDSA certificates to your application
--------------------------------------------------------------------------------

#. Close the untitled panel

#. Close the previous declaration.

#. Open ``Step3_as3_ecdsaCerts_Autodiscovery.json`` and select all of the text.


    .. image:: ./images/02as3_step3a.png
        :alt: load JSON file
        :width: 80%

#. Right click and select ``POST as AS3 Declaration``.

    .. image:: ./images/02as3_step3b.png
        :alt: POST as AS3 declaration
        :width: 80%



    .. image:: ./images/02as3_step3_success.png
        :alt: Posting Declaration
        :width: 80%



#. In the Management GUI for both BIG-IP devices, confirm the creation of:

     * Two ECDSA certificates were created
         * System -> certificate Management ->Traffic Certificate Management -> SSL Certificate List 

    .. image:: ./images/02as3_step3_ecdsacerts.png
        :alt: BIGIP management GUI ECDSA certificates
        :width: 80%

#. In the browser verify that you see the ECDSA ciphers in use.        


    .. image:: ./images/developertools.png
        :alt: BIGIP management GUI shared pool verification
        :width: 50%

    .. image:: ./images/02as3_step3_ciphers.png
        :alt: BIGIP management GUI http2 verification
        :width: 80%






