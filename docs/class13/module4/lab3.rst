BIG-IP CFE and AWS Resource Tag Dependencies
================================================================================

Check F5 CFE Status
--------------------------------------------------------------------------------

**TMUI**

#. On the TMUI of **BIG-IP #1**, navigate to **iApps > Package Management LX**.

#. Verify that the **f5-cloud_failover** package has been installed.

   .. image:: ./images/cfe-bigip-status-iapps.png
      :scale: 50%

#. Repeat for **BIG-IP #2**.

**Postman**

#. In Postman, expand the **Module 4 - Cloud Failover Extension** folder.

#. Click on the **CFE-1-A [bigip1] Get extension status** request and send it to the BIG-IP.

   A response status code of "200 OK" indicates CFE is ready.

   The response body should also contain contain version information (JSON format).

   .. image:: ./images/cfe-postman-verify-1a.png
      :scale: 50%

   |

#. Repeat for the **CFE-1-B [bigip2] Get extension status** request and confirm that a response status code of "200 OK" is returned.

   .. image:: ./images/cfe-postman-verify-1b.png
      :scale: 50%

|

Check AWS Resource Tags for CFE Failover Objects
--------------------------------------------------------------------------------

#. In the AWS Console, navigate to **Services > EC2 > NETWORK & SECURITY > Elastic IPs**.

#. Select the Elastic IP (public IP) mapped to private IP address **10.0.1.101**.

#. Select the **Tags** tab below. Note the Elastic IP has been tagged for use with CFE.

   .. image:: ./images/cfe-aws-tags-eip.png
      :scale: 50%

   |

#. In the AWS Console, navigate to **Services > VPC > Route Tables**.

#. Select the **f5lab_hub_default_rt** route table.

#. Select the **Tags** tab below. Note the route table has been tagged for use with CFE.

   .. image:: ./images/cfe-aws-tags-rt.png
      :scale: 50%

   |

#. In the AWS Console, navigate to **Services > Amazon S3**. Note the S3 bucket has been tagged for use with CFE.

   .. image:: ./images/cfe-aws-tags-s3.png
      :scale: 50%
