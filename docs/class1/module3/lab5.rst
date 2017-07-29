Autoscale WAF
-------------

1. Navigate to Services => AUTO SCALING => Auto Scaling Groups. Filter on your username and select your waf-userxx... auto scaling group.

2. Select the 'Instances' tab below, and select your Instance ID (there should be only one). If your instance is "Protected from... Scale in" then it will always stay up regardless of scale up/down thresholds configured.

.. image:: ./images/autoscale-pending.png
  :scale: 50%

3. Select the Scaling Polices tab. These policies were deployed via the CloudFormation template and can be changed via the CloudFormation template.

.. image:: ./images/autoscale-policy2.png
  :scale: 50%

4. Login to the active BIG-IP Autoscale Instance MGMT IP **on port 8443** configuration utility (web ui). Using the examples in our lab-info output in earlier tasks: https://52.207.200.169:8443

.. code-block:: bash

   ./scripts/lab-info

5. In the Big-IP Configuration utility (Web UI) navigate to Security -> Application Security -> Security Policies -> Active Polices. A "linux-high" policy was deployed via CloudFormation template and is in Enforcment Mode: Blocking.

.. image:: ./images/waf-policy.png
  :scale: 50%

6. From the f5-super-netops container, let's launch some traffic against the application behind our WAF and watch it autoscale to service the surge! Replace the https://waf-userxx... in the command below with the one in the output of lab-info and don't miss that critical forward slas / at the end!

.. code-block:: bash

   ab -t 120 -c 100 https://waf-user01f5io-xxxxxxxxx.us-east-1.elb.amazonaws.com/

7. Navigate to Service => INSTANCES => Instances. Filter on your username and after 60 seconds (the lowest configurable time threshold) hit refresh to see your 2nd autoscale WAF instance starting.

.. image:: ./images/autoscale-initializing.png
  :scale: 50%
