Import the SSL Certificate and Create Client SSL Profiles
----------------------------------------------------------

1. Go to “System > Certificate Management > Traffic Certificate
   Management > SSL Certificate List” and click “Import”

2. Import type: key

.. NOTE:: On this lab guide, X must be replaced by your student number given at the beginning of this session.

3. Key Name: careX-secureapigw.acmelatamlab.f5.com

4. Upload the Key file (privkey1.pem) or Paste its contents. You can
   find the files on a folder called “Certificates” on the Desktop.

5. Click Import
   
   |image13|

6. In the SSL Certificate List, click the name of the certificate you
   are importing

7. Verify you are in the Certificate tab, paste or upload cert1.pem file
   and click Import

   |image14|

8. We need to import the Intermediate Certificate (Chain). Make sure you are on “System > Certificate Management > Traffic Certificate
   Management > SSL Certificate List” and click “Import”

9. Import Type: Certificate

10. Certificate Name: intermediate\_careX

11. Upload chain1.pem or paste its contents. Click Import.
   
   |image15|

12. Go to “Local Traffic > Profiles > SSL > Client” and click Create.

13. Name: careX-secureapigw.acmelatamlab.f5.com

14. On Certificate Key Chain, select Custom check box and then Add.

15. Certificate: careX-secureapigw.acmelatamlab.f5.com

   Key: careX-secureapigw.acmelatamlab.f5.com

   Chain: intermediate\_careX

   Click Add
 
   |image16|

16. Click Finished

.. |image13| image:: image13.png
.. |image14| image:: image14.png
.. |image15| image:: image15.png
.. |image16| image:: image16.png
