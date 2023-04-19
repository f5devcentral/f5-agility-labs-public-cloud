Deploy AS3 declarations with F5 VS Code Extension
===============================================================================


Connect to BIG-IPs
--------------------------------------------------------------------------------

#. Go to the **BIG-IP #1** TMUI. Notice that it is in the **Standby** state. Leave it as is for now.


#. Navigate to **Local Traffic > Virtual Servers**. Note that have two administrative partitions: **Common** and **LOCAL_ONLY**.

   **Common** is the default parititon. **LOCAL_ONLY** is a special partition that was created during the onboarding process to support configurations unique to each BIG-IP (will not be synchronized).

    **BIG-IP #1**

    .. image:: ./images/01as3_noconfig.png
       :alt: BIGIP management GUI no config
       :width: 95%

    **BIG-IP #2**

    .. image:: ./images/01as3_noconfig_2.png
       :alt: BIGIP management GUI no config
       :width: 95%

    |


Create HTTP Virtual Servers with AS3 and Service Discovery
--------------------------------------------------------------------------------

#. Close the **as3check_makehttprequest.json** file.


#. Switch to the file Explorer view in **VS Code**.

    .. image:: ./images/icon_VS CodeExplorer_inactive.png
       :width: 70px
       :alt: File/folder explorer icon

    |

#. Navigate to the **ATC/AS3** directory.


#. Open the **Step1_as3_AWS_Autodiscovery.json** file.  In the window with the JSON declaration, select all of the text.  Scroll down and you will see that we are telling AS3 to look for tagged AWS EC2 instances to add to the pool.

    .. image:: ./images/02as3_step1a.png
       :alt: load JSON file
       :width: 90%

    |

#. Select all of the text and right click. Then, select **Post as AS3 Declaration**.

    .. image:: ./images/02as3_step1b.png
       :alt: POST as AS3 declaration
       :width: 90%

    |


#. As the extension waits for AS3 to validate and apply the declaration, you will see the following:

    .. image:: ./images/02as3_step1c.png
       :alt: Posting Declaration
       :width: 90%

    |


#. Here you can see that all sections of the declaration were successful. Below the highlighted box is the declaration that you submitted.

    .. image:: ./images/02as3_step1_success.png
       :alt: Successful deployment
       :width: 90%

    |


#. In the TMUI of both BIG-IP devices, confirm the creation of:

    * A new BIG-IP administrative partition (AS3 'tenant')
    * A new Pool with two pool members
    * Two new virtual servers

    .. note::

       Since configuration sync was enabled as part of the BIG-IP onboarding, you will see the same configuration on both BIG-IP instances.

    |

    **BIG-IP #1**

    .. image:: ./images/02as3_step1verify1.png
       :alt: BIGIP management GUI partition verification
       :width: 90%

    |

    .. image:: ./images/02as3_step1verify1pool.png
       :alt: BIGIP management GUI shared pool verification
       :width: 90%

    |

    .. image:: ./images/02as3_step1verify1vs.png
       :alt: BIGIP management GUI VS verification
       :width: 90%

    |

    **BIG-IP #2**

    .. image:: ./images/02as3_step1verify2.png
       :alt: BIGIP management GUI partition verification
       :width: 90%

    |

    .. image:: ./images/02as3_step1verify2pool.png
       :alt: BIGIP management GUI shared pool verification
       :width: 90%

    |

    .. image:: ./images/02as3_step1verify2vs.png
       :alt: BIGIP management GUI VS verification
       :width: 90%

    |


Enable HTTP/2 with AS3
--------------------------------------------------------------------------------

By default, BIG-IP uses HTTP/1.1. HTTP/2 is a more modern HTTP protocol version.


#. Close the **untitled** file tab.


#. Close the **Step1_as3_AWS_Autodiscovery.json** file tab.


#. Open **Step2_as3_HTTPS_ModernProtocols_Autodiscovery.json**, select all of the text, right click, and then select **POST as AS3 Declaration**.

    .. image:: ./images/02as3_step2a.png
       :alt: load JSON file
       :width: 90%

    |

    .. image:: ./images/02as3_step2b.png
       :alt: POST as AS3 declaration
       :width: 90%

    |

    .. image:: ./images/02as3_step1c.png
       :alt: Posting Declaration
       :width: 90%

    |


#. When successful, the BIG-IP will return a status code of **200** and a message of **SUCCESS**.

    .. image:: ./images/02as3_step2_success.png
       :alt: Successful deployment
       :width: 90%

    |


#. In the TMUI of both BIG-IP devices, confirm the following:

   * Two **HTTPS virtual servers** were created
   * The two irtual servers have an **HTTP/2 Profile (Client)** attached


    .. image:: ./images/02as3_step2_vs.png
       :alt: BIGIP management GUI VS verification
       :width: 90%

    .. image:: ./images/02as3_step2_vshttp2.png
       :alt: BIGIP management GUI http2 verification
       :width: 90%

    |


#. Now, you will verify connectivity to the HTTPS application and examine the ciphers used.

   * Open the web browser and, navigate to the IP address **vip1_public_ip** (refer to ``terraform output`` if needed).
   * Use the web browser's **developer tools** to see the ciphers in use.

    .. image:: ./images/02as3_step2_web.png
       :alt: BIGIP management GUI shared pool verification
       :width: 90%

    |

    .. image:: ./images/developertools.png
       :alt: BIGIP management GUI shared pool verification
       :width: 70%

    |

    .. image:: ./images/02as3_step2_Ciphers.png
       :alt: BIGIP management GUI VS verification

    |


Adding ECDSA certificates to the application
--------------------------------------------------------------------------------

Elliptic Curve Cryptography (ECC) provides strong security with smaller key sizes than traditional RSA cryptography. ECC is also more computationally efficient, which is better for use with mobile devices. You will now apply ECDSA certificates to your application virtual servers.

#. Close the **untitled** file tab.


#. Close the previous AS3 declaration.


#. Open **Step3_as3_ecdsaCerts_Autodiscovery.json** and select all of the text.

    .. image:: ./images/02as3_step3a.png
       :alt: load JSON file
       :width: 90%

    |


#. Right click and select **POST as AS3 Declaration**.

    .. image:: ./images/02as3_step3b.png
       :alt: POST as AS3 declaration
       :width: 90%

    |

    .. image:: ./images/02as3_step3_success.png
       :alt: Posting Declaration
       :width: 90%

    |


#. In the TMUI of both BIG-IP devices, confirm the following:

    * Two ECDSA certificates were created
        * **System > certificate Management > Traffic Certificate Management > SSL Certificate List**

    .. image:: ./images/02as3_step3_ecdsacerts.png
       :alt: BIGIP management GUI ECDSA certificates
       :width: 90%

    |


#. In the browser, verify that you see the ECDSA ciphers in use.

    .. image:: ./images/developertools.png
       :alt: BIGIP management GUI shared pool verification
       :width: 70%

    |

    .. image:: ./images/02as3_step3_ciphers.png
       :alt: BIGIP management GUI http2 verification
       :width: 90%

