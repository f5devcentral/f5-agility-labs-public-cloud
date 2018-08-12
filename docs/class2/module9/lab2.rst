Enable Enhanced Analytics
-------------------------

From Big-IQ, click on app2. Enable Enhanced Analytics. Match the settings in the screenshot below. Click Start.

.. image:: ./images/6_enable_enhanced_analytics.png
  :scale: 50%

From Big-IQ, navigate to ENVIRONMENT => CONFIGURATION => Device => [View Health Statistics]. You can monitor the health status of the device based on custom thresholds here (cpu % exceeded, etc.)

.. image:: ./images/7_health_statistics.png
  :scale: 50%

.. image:: ./images/8_health_statistics.png
  :scale: 50%

Note the Device Address. This is the same address assigned as the public IP of the virtual server. You can https to this address to see our sample application. You can generate a modest amount of traffic by hitting the new application yourself with a few https requests by refreshing your browser with the [F5] key.

.. image:: ./images/9_https_app.png
  :scale: 50%
