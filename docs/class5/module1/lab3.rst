Create a Server SSL Profile
---------------------------

Have you ever wonder how services like CloudFront can share an IP
Address with multiple domains, each one with a specific SSL Certificate?
To solve this issue they make use of SNI (Server Name Indication) to
distinguish which Domain you want to connect and use the right
certificate.

There is another option to use dedicated IP Address and SSL certificate,
that can cost up to US$600 per month in AWS charges.

For this lab we are using the first option :-)

F5 BIG-IP supports SNI since version 11.1, released in 2015.

1. Go to “Local Traffic > Profiles > SSL > Server” and click Create

2. Name: serverssl\_YOUR\-CLOUDFRONT\-TARGET\-DOMAIN
   E.g.: serverssl\_dieixb12vz0gy.cloudfront.net

3. Select Advanced

4. Server Name: YOUR\_CLOUDFRONT\-TARGET\-DOMAIN
   E.g.: dieixb12vz0gy.cloudfront.net

   |image17|

5. Click Finished

.. |image17| image:: image17.png
