Review Telemetry Streaming Logs in the AWS Console Using CloudWatch
================================================================================

#. In the **AWS Console**, navigate to **Services** and then type ``cloudwatch`` in the search box at the top of the page.

#. Click on **CloudWatch** from the drop-down results.

   .. image:: ./images/2023_7_aws_console_search_cloudwatch.png
      :scale: 50%

   |

#. Navigate to **Logs > Log Groups > studentf5labdev > log-stream**.

#. Click on the refresh button until you see log entries for each of the BIG-IPs.

   .. image:: ./images/2023_8_aws_console_cloudwatch_logstream.png
      :scale: 50%

   |

#. Once system telemetry data appears from hostname: **ip-10-0-101-11.us-west-2.compute.internal.com** and hostname: **ip-10-0-102-11.us-west-2.compute.internal.com**, click on the drop down for one of the log entries to examime the system data.

   .. image:: ./images/2023_9_aws_console_cloudwatch_telemetry_streaming.png
      :scale: 50%

   |

#. Scroll though the log data to view the system metrics being sent by each of the BIG-IPs to CloudWatch.

|

.. note::

   Each BIG-IP is sending Telemetry Streaming logs to CloudWatch every 60 seconds. This is the **interval** value that was defined in the **Telemetry Streaming** declaration.

|

This is the end of the lab module.
