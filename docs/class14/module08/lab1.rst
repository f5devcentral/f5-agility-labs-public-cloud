F5 Telemetry Streaming (TS) to GCP Monitoring
---------------------------------------------

The Telemetry Streaming package has been installed as part of the base image.  You can verify it is installed by going to iApps => Package Management LX, where you can note the version.

From F5 VScode Extension, “Lab - Telemetry Streaming” => “Step 1: Confirm Telemetry Streaming REST API - BIGIP1” => [Send].

"Status: 200 OK" response signals that the Telemetry Streaming Extension (TS) is ready on Big-IP1.

.. image:: ./images/2_postman_telemetry_streaming_status_bigip1.png
	   :scale: 50%

From F5 VScode Extension, “Lab4.5-TS” click on Lab4.5-TS under the drop down menu, select "ts.json" request.
Right Click "Post as TS Declaration".

.. image:: ./images/1_ts1.png
	   :scale: 50%

"Status: 200 OK" response signals that the Telemetry Streaming Extension (TS) declaration successfully completed processing on Big-IP1.

.. image:: ./images/2_ts2.png
	   :scale: 50%

From the GCP Console, Services => type "Monitoring" in the search box, choose "Monitoring" from the drop-down results.

.. image:: ./images/3_ts3.png
	   :scale: 50%

From the GCP Console, Monitoring => Metrics explorer 

.. image:: ./images/4_ts4.png
	   :scale: 50%

Click on query editor in the editor type fetch generic_node :: custom/system/cpu. Then click Run Query

.. image:: ./images/4_ts4.png
	   :scale: 50%

		

Eventually you will see telemetry data 


