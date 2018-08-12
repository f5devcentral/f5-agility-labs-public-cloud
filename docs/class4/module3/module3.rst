BIG-IP ASM Configuration
========================

Let's review what we achieved so far:

- F5 BIG-IP positioned in front of the AWS API Gateway
- DNS record careX-secureapigw.acmelatamlab.f5.com pointing to the F5 BIG-IP
- All request signing is working fine, since we configured careX-secureapigw.acmelatamlab.f5.com as a Custom Domain Name in the API Gateway.
- All communication is secure (TLS) and we are using SNI on the server side.

All we need to do now is protect the API Gateway (REST). Let's do it!

.. toctree::
   :maxdepth: 1
   :glob:

   lab*
