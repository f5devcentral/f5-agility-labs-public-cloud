F5 Telemetry Streaming (TS) to Google Cloud Operations Suite’s Cloud Monitoring
-------------------------------------------------------------------------------

The Telemetry Streaming package has been installed as part of the base image.  You can verify it is installed by going to iApps => Package Management LX, where you can note the version.

.. image:: ./images/00_bigip_ts_check.png
	   :scale: 75%

Make sure you are signed into BIG-IP 1, click on TS the bottom blue bar. 

.. image:: ./images/01_vs_ts_validation.png
	   :scale: 75%

"message:Success" response signals that the Telemetry Streaming Extension (TS) is ready on Big-IP1.

From files tab click on Lab4.5-TS under the drop down menu, select "ts.json" request.
Right Click "Post as TS Declaration".

.. image:: ./images/1_ts1.png
	   :scale: 75%

"message:Success" response signals that the Telemetry Streaming Extension (TS) declaration successfully completed processing on Big-IP1.

.. image:: ./images/03_ts_success.png
	   :scale: 75%

Go to the ip address for both webapp_1 and webapp_2 and refresh the page 10 times.

.. image:: ./images/9_example_app_bigip1.png
	   :scale: 75%

Now from the GCP Console, Services => type "Monitoring" in the search box, choose the first "Monitoring" option from the drop-down results.

.. image:: ./images/3_ts3.png
	   :scale: 75%

From Monitoring on the side panel => Metrics explorer.

.. image:: ./images/4_ts4.png
	   :scale: 75%

Click on query editor in the editor type fetch generic_node :: custom/system/cpu. Then click Run Query.

.. image:: ./images/10_gcp_monitoring_metrics_q_edit.png
	   :scale: 75%

.. image:: ./images/11_gcp_query_results.png
	   :scale: 75%

		

Eventually you will see telemetry data.

