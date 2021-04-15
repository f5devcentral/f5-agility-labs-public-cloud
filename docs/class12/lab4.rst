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

|image46|

This should take you to the “OWASP Juice Shop App”

|image47|

Find out all about it here: https://github.com/bkimminich/juice-shop

Online Guide to Vulnerabilities in the Juice Shop App and how to exploit
them:

https://pwning.owasp-juice.shop/

Next go to the URL listed at **rSyslogHttp_8080**. It should look like
the below. Not that it is on port 8080 and http not https.

|image48|

This will take us to our example Syslog Server:

Username: **xadmin**

Password: **pleaseUseVault123!!**

|image49|

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

|image50|

Notice that none of the objects are in the Common partition so you will
need to show all partitions to get a full view.

|image51|

Once you are done we can proceed to the last step and clean up.

Go back to Git Bash and Type :

**terraform destroy**

You will be prompted to type in “\ **yes**\ ” then the entire resource
group will be deleted.

Please let this run until completion.

|image52| This is the end of Module 4!

.. |image0| image:: media/image1.png
   :width: 5.42964in
   :height: 3.15444in
.. |image1| image:: media/image2.png
   :width: 3.84617in
   :height: 1.76682in
.. |Diagram Description automatically generated| image:: media/image3.png
   :width: 6.5in
   :height: 8.77847in
.. |image3| image:: media/image4.png
   :width: 6.5in
   :height: 1.25556in
.. |image4| image:: media/image5.png
   :width: 5.41297in
   :height: 2.53772in
.. |image5| image:: media/image6.png
   :width: 5.38797in
   :height: 2.79191in
.. |image6| image:: media/image7.png
   :width: 1.67098in
   :height: 0.85841in
.. |image7| image:: media/image8.png
   :width: 3.40029in
   :height: 1.86266in
.. |image8| image:: media/image9.png
   :width: 4.74208in
   :height: 4.01701in
.. |image9| image:: media/image10.png
   :width: 1.23761in
   :height: 4.22953in
.. |image10| image:: media/image11.png
   :width: 2.76274in
   :height: 1.47513in
.. |image11| image:: media/image12.png
   :width: 2.84191in
   :height: 2.86691in
.. |image12| image:: media/image13.png
   :width: 2.85858in
   :height: 3.4378in
.. |image13| image:: media/image14.png
   :width: 2.76918in
   :height: 0.61667in
.. |image14| image:: media/image15.png
   :width: 1.19177in
   :height: 4.15869in
.. |image15| image:: media/image16.png
   :width: 3.07527in
   :height: 0.99175in
.. |image16| image:: media/image17.png
   :width: 0.95425in
   :height: 4.15869in
.. |image17| image:: media/image18.png
   :width: 6.36305in
   :height: 3.66282in
.. |image18| image:: media/image19.png
   :width: 4.90459in
   :height: 4.10036in
.. |image19| image:: media/image20.png
   :width: 6.33388in
   :height: 3.69615in
.. |image20| image:: media/image21.png
   :width: 6.5in
   :height: 5.36875in
.. |image21| image:: media/image22.png
   :width: 4.15869in
   :height: 0.59172in
.. |image22| image:: media/image23.png
   :width: 5.09628in
   :height: 1.03759in
.. |image23| image:: media/image24.png
   :width: 6.14637in
   :height: 5.87551in
.. |image24| image:: media/image25.png
   :width: 4.2337in
   :height: 0.83341in
.. |image25| image:: media/image26.png
   :width: 5.92551in
   :height: 2.65023in
.. |image26| image:: media/image27.png
   :width: 6.5in
   :height: 1.64444in
.. |image27| image:: media/image28.png
   :width: 3.12944in
   :height: 2.00434in
.. |image28| image:: media/image29.png
   :width: 6.27554in
   :height: 6.46723in
.. |image29| image:: media/image30.png
   :width: 5.8005in
   :height: 2.15852in
.. |image30| image:: media/image31.png
   :width: 2.30437in
   :height: 2.27936in
.. |image31| image:: media/image32.png
   :width: 3.1211in
   :height: 1.20844in
.. |image32| image:: media/image33.png
   :width: 6.5in
   :height: 4.32708in
.. |image33| image:: media/image34.png
   :width: 0.42917in
   :height: 0.42917in
.. |image34| image:: media/image35.png
   :width: 6.5in
   :height: 2.87431in
.. |image35| image:: media/image36.png
   :width: 5.4088in
   :height: 3.1336in
.. |image36| image:: media/image37.png
   :width: 3.40863in
   :height: 1.77515in
.. |image37| image:: media/image34.png
   :width: 0.42917in
   :height: 0.42917in
.. |image38| image:: media/image38.png
   :width: 4.62083in
   :height: 1.29035in
.. |image39| image:: media/image39.png
   :width: 5.67917in
   :height: 2.91733in
.. |image40| image:: media/image40.png
   :width: 6.5in
   :height: 3.00069in
.. |image41| image:: media/image41.png
   :width: 1.96667in
   :height: 1.59745in
.. |image42| image:: media/image42.png
   :width: 3.72116in
   :height: 0.56672in
.. |image43| image:: media/image43.png
   :width: 6.35472in
   :height: 3.66698in
.. |image44| image:: media/image44.png
   :width: 6.5in
   :height: 4.23889in
.. |image45| image:: media/image34.png
   :width: 0.42917in
   :height: 0.42917in
.. |image46| image:: media/image45.png
   :width: 3.66698in
   :height: 0.97925in
.. |image47| image:: media/image46.png
   :width: 6.5in
   :height: 3.13889in
.. |image48| image:: media/image47.png
   :width: 3.66698in
   :height: 0.97925in
.. |image49| image:: media/image48.png
   :width: 6.5in
   :height: 3.05347in
.. |image50| image:: media/image49.png
   :width: 6.5in
   :height: 3.48125in
.. |image51| image:: media/image50.png
   :width: 6.5in
   :height: 3.55347in
.. |image52| image:: media/image34.png
   :width: 0.42917in
   :height: 0.42917in
