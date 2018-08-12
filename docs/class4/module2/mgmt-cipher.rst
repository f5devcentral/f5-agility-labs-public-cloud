SSL Security of F5 Management
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**There are some vulnerabilities in the default HTTPS access of the management on the F5 documented here: |K13400|

**To protect against this we will disable all non-TLSv1.2 connections to the management by doing the following:**

#. Log in to the SSH of the F5 BIG-IP by using the same method previously used to change admin password:

     :guilabel:`ssh -i student#-BIG-IP.pem admin@<EIP Host Address for Management network>`

#. Before you change the SSL cipher string, you should review the existing string for your specific BIG-IP version. To list the currently configured cipher string, type the following command:
    
     :guilabel:`list /sys httpd ssl-ciphersuite`

   For example, the BIG-IP 13.1.7 system displays the following cipher string:

   ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-SHA:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES128-SHA:ECDHE-ECDSA-AES256-SHA:ECDHE-ECDSA-AES128-SHA256:ECDHE-ECDSA-AES256-SHA384:AES128-GCM-SHA256:AES256-GCM-SHA384:AES128-SHA:AES256-SHA:AES128-SHA256:AES256-SHA256:ECDHE-RSA-DES-CBC3-SHA:ECDHE-ECDSA-DES-CBC3-SHA:DES-CBC3-SHA

#. To restrict Configuration utility access to clients using TLS 1.2 or RC4-SHA ciphers, type the following command:

     :guilabel:`modify /sys httpd ssl-ciphersuite ALL:!ADH:!EXPORT:!eNULL:!MD5:!DES:!SSLv2:-TLSv1:-SSLv3:RC4-SHA`

   Alternatively, if you want to restrict to only TLS 1.1 and TLS 1.2 ciphers, then type the following command instead:

     :guilabel:`modify /sys httpd ssl-ciphersuite ALL:!ADH:!EXPORT:!eNULL:!MD5:!DES:!SSLv2:!SSLv3:!TLSv1`

#. Save the configuration change by typing the following command:

     :guilabel:`save /sys config`

.. |K13400| raw:: html

    <a href="https://support.f5.com/csp/article/K13400" target="_blank">https://support.f5.com/csp/article/K13400</a>