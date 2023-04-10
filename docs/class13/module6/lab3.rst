Verify installation of F5 Telemetry Streaming
================================================================================
Verify that F5 Telemetry Streaming has been installed via the WebUI and API


Verify installation via the WebUI
--------------------------------------------------------------------------------

From Big-IP1, iApps => Package Management LX. Note the f5-telemetry package is installed.

Do the same for Big-IP2.

.. image:: ./images/2023_1_bigip1_telemetry_streaming_icontrol_lx_installed.png
	   :scale: 50%


Verify installation via API
--------------------------------------------------------------------------------

From Postman, “Lab 4.6 - Telemetry Streaming” => “Step 1: Confirm Telemetry Streaming REST API - BIGIP1” => [Send].

"Status: 200 OK" response signals that the F5 Telemetry Streaming Extension (BIG-IP TS) is ready on Big-IP1.

.. image:: ./images/2023_2_postman_telemetry_streaming_status_bigip1.png
	   :scale: 50%

From Postman, “Lab 4.6 - Telemetry Streaming” => “Step 2: Confirm Telemetry Streaming REST API - BIGIP2” => [Send].

"Status: 200 OK" response signals that the F5 Telemetry Streaming Extension (BIG-IP TS) is ready on Big-IP2.

.. image:: ./images/2023_3_postman_telemetry_streaming_status_bigip2.png
	   :scale: 50%


