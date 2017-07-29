Autoscale WAF
-------------

1. Navigate to Services => AUTO SCALINE => Auto Scaling Groups. Filter on your username and select your waf-userxx... auto scaling group.
2. Select the 'Instances' tab below, and select your Instance ID (there should be only one). If your instance is "Protected from... Scale in" then it will always stay up regardless of scale up/down thresholds configured.
3. Select the Scaling Polices tab. These policies were deployed via the CloudFormation template and can be changed via the CloudFormation template.
4. Login to the active BIG-IP Autoscale Instance MGMT IP **on port 8443** configuration utility (web ui). Using the examples in our lab-info output in earlier tasks: https://54.165.15.2:8443.

.. code-block:: bash

   ./scripts/lab-info

5. From the f5-super-netops container, let's generate launch some traffic against the application behind our WAF and watch it autoscale to service the surge! Replace the https://waf-userxx... in the command below with the one in the output of lab-info and don't miss that you have tack on a / at the end of the url.

.. code-block:: bash

   ab -t 120 -c 100 https://waf-user01f5io-xxxxxxxxx.us-east-1.elb.amazonaws.com/

6. Navigate to Service => INSTANCES => Instances. Filter on your username and after 60 seconds (the lowest configurable time threshold) hit refresh to see your 2nd autoscale WAF instance starting.
