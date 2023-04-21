Verify installation of F5 Telemetry Streaming
================================================================================

Verify that the **Telemetry Streaming** extension has been installed via the TMUI and API.


Verify installation via the TMUI
--------------------------------------------------------------------------------

#. From BIG-IP #1, navigate to **iApps > Package Management LX**. Note that the **f5-telemetry** package is installed.

#. Do the same for BIG-IP #2.

   .. image:: ./images/2023_1_bigip1_telemetry_streaming_icontrol_lx_installed.png
      :scale: 50%


Verify installation via API
--------------------------------------------------------------------------------

#. In Postman, expand the **Module 6 - Telemetry Streaming** folder.

#. Click on the **TS-1-A [bigip1] Get extension status** request and send it to the **BIG-IP #1**.

   A response status code of "200 OK" indicates TS is ready.

   .. image:: ./images/2023_2_postman_telemetry_streaming_status_bigip1.png
      :scale: 50%

   |

#. Click on the **TS-1-B [bigip2] Get extension status** request and send it to the **BIG-IP #2**.

   A response status code of "200 OK" indicates TS is ready.

   .. image:: ./images/2023_3_postman_telemetry_streaming_status_bigip2.png
      :scale: 50%

