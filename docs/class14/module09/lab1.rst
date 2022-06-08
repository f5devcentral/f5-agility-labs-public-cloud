F5 Telemetry Streaming to Google Cloud Operations Suite’s Cloud Monitoring
============================================================================

In two browser tabs, go to the ip address for webapp_external and refresh 
the page 10 or more times.  The intent is to create some utilization on 
the BIG-IP that will then be sent to the GCP monitoring infrastructure.

.. image:: ./images/webappexternal.png
   :scale: 60%
   :alt: Example app

Now from the GCP Console, Services => type "Monitoring" in the search box,
choose the first "Monitoring" option from the drop-down results.

.. image:: ./images/TS_GCP_MonitoringSearch.png
   :scale: 60%
   :alt: Google Console Monitoring search

From Monitoring on the side panel => Metrics explorer.

.. image:: ./images/Lab4.2_GCloudConsoleMetricsExplorer.png
   :scale: 60%
   :alt: GCloud Metrics explorer

Click on query editor in the editor type fetch generic_node ::
custom/system/cpu. Then click Run Query.

.. image:: ./images/Lab4.2_GCloudConsoleSelectMetric.png
   :scale: 60%
   :alt: Gcloud Metrics Explorer select Metric

.. image:: ./images/Lab4.2_GCloudConsoleMetricsExplorerGraph.png
   :scale: 60%
   :alt: Graph

This may take a few minutes, but eventually you will see telemetry data start
to be shown.
