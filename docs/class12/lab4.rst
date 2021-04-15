4.0 Lab Module 4
================

In this lab we will explore the demo applications and remote access
methods for the deployment. This is less of a formal lab and more about
showing you how to get to things and letting you explore on your own
before we run terraform destroy and clean up the deployment.

4.1 Accessing the Demo Applications

In the output at the end of lab 3 find the URL listed for
**DemoAppplication_443** and copy that into the browser. Your IP address
will be different from the one below.

|image45|

This should take you to the “OWASP Juice Shop App”

|image46|

Find out all about it here: https://github.com/bkimminich/juice-shop

Online Guide to Vulnerabilities in the Juice Shop App and how to exploit
them:

https://pwning.owasp-juice.shop/

Next go to the URL listed at **rSyslogHttp_8080**. It should look like
the below. Not that it is on port 8080 and http not https.

|image47|

This will take us to our example Syslog Server:

Username: **xadmin**

Password: **pleaseUseVault123!!**

|image48|

All of our logs from the IPS and BIG-IP devices are being sent here.
Feel free to explore.

https://github.com/potsky/PimpMyLog

https://www.pimpmylog.com/

Now open your local RDP client and RDP to the same public IP address as
the demo apps:

When prompted use:

Username: xadmin

Password: pleaseUseVault123!!

From this Windows Jump host you can use a browser to connect to the
Management Console on the BIG-IP devices.

**BIG-IP Devices**

10.90.0.4

10.90.0.5

10.90.0.6

10.90.0.7

|image49|

Notice that none of the objects are in the Common partition so you will
need to show all partitions to get a full view.

|image50|

Once you are done we can proceed to the last step and clean up.

Go back to Git Bash and Type :

**terraform destroy**

You will be prompted to type in “\ **yes**\ ” then the entire resource
group will be deleted.

Please let this run until completion.

|image34| This is the end of Module 4!

.. |image45| image:: media/image45.png
.. |image46| image:: media/image46.png
.. |image47| image:: media/image47.png
.. |image48| image:: media/image48.png
.. |image49| image:: media/image49.png
.. |image50| image:: media/image50.png
.. |image34| image:: media/image34.png
