BIG-IP CFE and AWS Resource Tag Dependencies
================================================================================

Check F5 CFE Status
--------------------------------------------------------------------------------

**TMUI**

#. On the TMUI of **BIG-IP #1**, navigate to **iApps > Package Management LX**.

#. Verify that the **f5-cloud_failover** package has been installed.

   .. image:: ./images/1_cloud_failover_installed.png
      :scale: 50%

#. Repeat for **BIG-IP #2**.

**Postman**

#. In Postman, expand the **Module 4 - Cloud Failover Extension** folder.

#. Click on the **CFE-1-A [bigip1] Get extension status** request and send it to the BIG-IP.

   A response status code of "200" indicates CFE is ready.

   .. image:: ./images/2_postman_check_cloud_failover_status_bigip1.png
      :scale: 50%

   |

#. Repeat for the **CFE-1-A [bigip1] Get extension status** request and confirm that a response status code of "200" is returned.

   .. image:: ./images/3_postman_check_cloud_failover_status_bigip2.png
      :scale: 50%

|

Check AWS Resource Tags for CFE Failover Objects
--------------------------------------------------------------------------------

#. In the AWS Console, navigate to **Services > EC2 > NETWORK & SECURITY > Elastic IPs**.

#. Select the Elastic IP (public IP) mapped to **10.0.1.101**.

#. Select the **Tags** tab below. Note the Elastic IP has been tagged for use with CFE.

   .. image:: ./images/4_aws_console_elastic_ip.png
      :scale: 50%

#. In the AWS Console, navigate to **Services > VPC > Route Tables**.

#. Select the **Default** route table.

#. Select the **Tags** tab below. Note the route table has been tagged for use with CFE.

   .. image:: ./images/5_aws_console_route_table_tag.png
      :scale: 50%

   |

#. In the AWS Console, navigate to **Services > S3**. Note the S3 bucket has been tagged for use with CFE.

   .. image:: ./images/6_aws_console_s3_bucket_tag.png
      :scale: 50%
