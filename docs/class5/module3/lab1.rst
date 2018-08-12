Create and Apply a logging profile
----------------------------------

1. Go to “Security > Event Logs > Logging Profiles” and click Create.

2. Profile Name: apigwlog

3. Select Application Security and DoS Protection

   |image32|

4. In the DoS Protection section, enable “Local Publisher”.

   |image33|

5. Go to Application Security section, change the request type to “All
   Requests”

   |image34|

6. Click Finish

7. Go to “Local Traffic > Virtual Servers > Virtual Servers List” and
   click on the Virtual Server you just created.

8. In the top menu, go to “Security” then “Policies”

9. Log Profile: apigwlog (Selected)

10. Click Update

.. |image32| image:: image32.png
.. |image33| image:: image33.png
.. |image34| image:: image34.png
