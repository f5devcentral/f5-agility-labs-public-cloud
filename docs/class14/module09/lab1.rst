F5 Telemetry Streaming to Google Cloud Operations Suite’s Cloud Monitoring
==========================================================================

In the previous lab, you should have generated some traffic that will 
appear in the Google Cloud monitoring infrastructure.

.. image:: ./images/webappexternal.png
   :scale: 60%
   :alt: Example app

Now from the Google Cloud Console, Services => type "Monitoring" in the search box,
choose the first "Monitoring" option from the drop-down results.

.. image:: ./images/TS_GCP_MonitoringSearch.png
   :scale: 60%
   :alt: Google Console Monitoring search

From Monitoring on the side panel => Metrics explorer.

.. image:: ./images/Lab4.2_GCloudConsoleMetricsExplorer.png
   :scale: 60%
   :alt: GCloud Metrics explorer

Click on box below Resource & Metric, select VM Instance --> Custom --> 
custom/system/throughputPerformance/sysPerformanceThroughputClientBitsOut/average and press apply.

.. image:: ./images/Lab4.2_GCloudConsoleSelectMetric.png
   :scale: 60%
   :alt: Gcloud Metrics Explorer select Metric

.. image:: ./images/Lab4.2_GCloudConsoleMetricsExplorerGraph.png
   :scale: 60%
   :alt: Graph

This may take a few minutes, but eventually you will see telemetry data start
to be shown.
