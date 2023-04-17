Subscribe to EC2 Instances
================================================================================

Before you can deploy EC2 virtual machine instances, you must **subscribe** to the instances that you want to use.

#. Type ``marketplace`` in the AWS Console search box at the top of the page.

   |

#. Click on **AWS Marketplace Subscriptions** from the search results.

   .. image:: ./images/aws-mkt-0.png
      :align: left

   |

#. In the menu to the left, click on **Discover products**. If you do not see this menu, click on the |hamburger| (*hamburger*) menu icon first.

#. Enter ``f5 advanced 25mbps`` in the **AWS Marketplace products** search box.

#. Click on **F5 Advanced WAF with LTM, IPI, and Threat Campaigns (PAYG, 25Mbps)**.

   .. image:: ./images/aws-mkt-1.png
      :align: left

   |

#. Click on **Continue to Subscribe**.

   .. image:: ./images/aws-mkt-2.png
      :align: left

   |

#. If there isn't an existing entitlement, click on the **Accept Terms** button. Otherwise, skip to the next step.

   .. image:: ./images/aws-mkt-3.png
      :align: left


   .. note::

      If you see an error message after clicking on the **Accept Terms** button, just click it again.

   .. image:: ./images/aws-mkt-error.png
      :align: left

   |

   When you are subscribed, you will see the **Effective Date** change from **Pending** to the current date.

   .. image:: ./images/aws-mkt-4.png
      :align: left

   |

   .. image:: ./images/aws-mkt-5.png
      :align: left


   For future reference, this is the link to the same EC2 subscription: |ec2-bigip|


   .. attention::

      Ensure that the subscription is successful (not **pending**) before proceeding to the next section.


#. Minimize your browser window (do not close it). You will return to it later.



.. |hamburger| image:: ./images/aws-mkt-menu.png

.. |ec2-bigip| raw:: html

      <a href="https://aws.amazon.com/marketplace/pp/prodview-cs4qijwjf3ijs" target="_blank"> F5 Advanced WAF with LTM, IPI, and Threat Campaigns (PAYG, 25Mbps) </a>

