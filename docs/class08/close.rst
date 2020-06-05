Conclusion
==========

Thank you for your participation in the PC221GCP-Deploying-BIG-IP-in-GCP-F5-Failover-Extension lab. 
This Lab Guide has highlighted several notable features deploying BIG-IP into google cloud. 
It does not attempt to review all F5 google integration
features and configurations but serves as an introduction to allow the
student to further explore the BIG-IP platform and Access Policy Manager
and google cloud integration with F5.

Appendix and Troubleshooting
============================

#.	How to delete  a deployment… from jump box type. 

gcloud deployment-manager deployments delete <name of your deployment>

NOTE… deployment deletion fails sometimes.. requires that storage bucket be deleted from inside the console.

See below.

.. code-block:: text

   Waiting for delete [operation-1577658115008-59adf2785a9bf-90292e3c-177ee45c]...failed.                    
   ERROR: (gcloud.deployment-manager.deployments.delete) Delete operation operation-1577658115008-59adf2785a9bf-90292e3c-177ee45c failed.
   Error in Operation [operation-1577658115008-59adf2785a9bf-90292e3c-177ee45c]: errors:
   - code: RESOURCE_ERROR
   location: /deployments/studentxdeployment/resources/f5-bigip-studentxdeployment-51958
   message: '{"ResourceType":"storage.v1.bucket","ResourceErrorCode":"409","ResourceErrorMessage":{"code":409,"errors":[{"domain":"global","message":"The
      bucket you tried to delete was not empty.","reason":"conflict"}],"message":"The
      bucket you tried to delete was not empty.","statusMessage":"Conflict","requestPath":"https://www.googleapis.com/storage/v1/b/f5-bigip-studentxdeployment-51958","httpMethod":"DELETE"}}'

#.	List device name..

>list cm device


#.	Notes on configuring failover https://clouddocs.f5.com/cloud/public/v1/google/Google_configsync.html




