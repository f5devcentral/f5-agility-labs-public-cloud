Deploy Telemetry Streaming Configuration
================================================================================

POST the TS Declaration
--------------------------------------------------------------------------------

#. In Postman, click on the **TS-2-A [bigip1] Configure TS for CloudWatch** request and send it to the BIG-IP.

   .. image:: ./images/2023_4_postman_telemetry_streaming_body_bigip1.png
      :scale: 50%

   |

   A response status code of "200 OK" indicates that the TS declaration was validated and accepted by the BIG-IP.

   .. image:: ./images/2023_5_postman_telemetry_streaming_completed_bigip1.png
      :scale: 50%

   |

#. Click on the **TS-2-B [bigip2] Configure TS for CloudWatch** request and send it to the BIG-IP.

   A response status code of "200 OK" indicates that the TS declaration was validated and accepted by the BIG-IP.

   .. image:: ./images/2023_6_postman_telemetry_streaming_completed_bigip2.png
      :scale: 50%

|

GET the TS Declaration
--------------------------------------------------------------------------------

#. Click on the **TS-2-A [bigip1] Configure TS for CloudWatch** request and change the request method from **POST** to **GET**. Send it to the BIG-IP.

   A response status code of "200 OK" indicates a successful request to TS. The TS configuration will be displayed in the **Response** pane.

   .. image:: ./images/2023_14_postman_telemetry_streaming_get_bigip1.png
      :scale: 50%

|

.. note::

   Changing the API call from a POST to a GET using the same URL will pull the **Telemetry System** configuration currently deployed on each BIG-IP. You can use this GET method to view the full **TS** configuration at anytime.

|

.. attention::

   Before closing the **“TS-2-A [bigip1] Configure TS for CloudWatch”** tab or the Postman application, it is best to change the request method back to the original value of **POST**. Otherwise, you will get a message asking if you would like to save changes to the declaration.
