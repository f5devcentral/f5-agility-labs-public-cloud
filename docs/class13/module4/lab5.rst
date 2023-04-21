Test HA failover
================================================================================

Verify application access
--------------------------------------------------------------------------------

#. From the VS Code terminal, note the value of **vip1_public_ip**.

   .. code-block:: bash

      terraform output vip1_public_ip

#. Open a new browser tab and connect  **https://<vip1_public_ip>**. If you still have a tab open to the example application from early, you can use that.


Check CFE Configuration
--------------------------------------------------------------------------------

#. From the VS Code terminal, SSH to the active BIG-IP and confirm the interfaces that CFE is tracking. Use the ``bigip1`` BASH alias to connect and then enter ``yes`` to trust the BIG-IP's SSH fingerprint.


#. You should be connected to a BASH prompt. Enter the following:

   .. code-block:: bash

      curl -su admin: http://localhost:8100/mgmt/shared/cloud-failover/inspect | jq .
      exit

   |

   .. image:: ./images/cfe-failover-ssh-bigip1.png
      :align: left

   |


#. From the VS Code terminal, SSH to the standby BIG-IP and confirm the interfaces that CFE is tracking. Use the ``bigip2`` BASH alias to connect and then enter ``yes`` to trust the BIG-IP's SSH fingerprint.

   .. code-block:: bash

      curl -su admin: http://localhost:8100/mgmt/shared/cloud-failover/inspect | jq .

   |

   .. image:: ./images/cfe-failover-ssh-bigip2.png
      :align: left

   |

Failover Dry-run Test
--------------------------------------------------------------------------------

#. While still connected to the standby BIG-IP, perform a failover **dry-run** to see what would happen during a failover event. Notice the **current** and **target** address mappings.

   .. code-block:: bash

      curl -su admin: -X POST -d '{"action":"dry-run"}' http://localhost:8100/mgmt/shared/cloud-failover/trigger | jq .

   |

   .. image:: ./images/cfe-failover-dryrun.png
      :align: left

   |


#. On the same BIG-IP (standby), watch the logs before triggering a failover event.

   .. code-block:: bash

      tail -f /var/log/restnoded/restnoded.log

   .. image:: ./images/cfe-failover-logging-1.png
      :align: left

   |

Force Failover to BIG-IP #2
--------------------------------------------------------------------------------

#. From **BIG-IP #1**, navigate to **Device Management > Devices > bigip1.f5lab.dev**.

   .. image:: ./images/cfe-failover-devices-bigip1.png
      :align: left

   |

#. Force **bigip1.f5lab.dev** to standby by clicking on the **Force to Standby** button.

   .. image:: ./images/cfe-failover-force-standby-bigip1.png
      :align: left

   |

#. In the top left corner, verify that the status changes to **ONLINE (STANDBY)**.

   .. image:: ./images/cfe-failover-bigip1-standby.png
      :align: left

   |

#. On **BIG-IP #2**, verify that the status has changed to **ONLINE (ACTIVE)**. **BIG-IP #2** was immediately promoted to active and **BIG-IP #1** demoted to standby.

   .. image:: ./images/cfe-failover-bigip2-active.png
      :align: left

   |

#. In the VS Code terminal, view the failover in the captured log messages.

   .. image:: ./images/cfe-failover-logging-2.png
      :align: left

   |

#. In the AWS Console, navigate to **Services > EC2 > Network & Security > Elastic IPs** and select the Elastic IP (public IP) previously mapped to private IP address **10.0.1.101**.

#. Click on the refresh button until you see the new mapping to **10.0.2.101** (**BIG-IP #2**).

   .. image:: ./images/cfe-failover-verify-aws-1.png
      :align: left

   |

#. Switch to the browser tab with the example application and press **<CTRL-F5>** a few times to refresh the page.

   We are using self-signed certificates in the lab, so will need to bypass the TLS warnings. Click on **Accept the Risk and Continue**.

   .. image:: ./images/cfe-failover-verify-web-1.png
      :align: left

   |

   The example application shows the Availability Zone for the pool member that is returning the content (not the active BIG-IP's AZ).

   .. image:: ./images/cfe-failover-verify-web-2.png
      :align: left

   |


Force Failback to BIG-IP #1
--------------------------------------------------------------------------------

#. From **BIG-IP #2**, navigate to **Device Management > Devices > bigip2.f5lab.dev**.


#. Force **bigip2.f5lab.dev** to standby by clicking on the **Force to Standby** button.

   .. image:: ./images/cfe-failover-force-standby-bigip2.png
      :align: left

   |

#. In the top left corner, verify that the status changes to **ONLINE (STANDBY)**.

   .. image:: ./images/cfe-failover-bigip2-standby.png
      :align: left

   |

#. On **BIG-IP #1**, verify that the status has changed to **ONLINE (ACTIVE)**. **BIG-IP #1** is now back to the active state.

   .. image:: ./images/cfe-failover-bigip1-active.png
      :align: left

   |

#. In the AWS Console, navigate to **Services > NETWORK & SECURITY > Elastic IPs** and select the Elastic IP (public IP) previously mapped to private IP address **10.0.2.101**.

#. Click on the refresh button until you see the new mapping to private IP address **10.0.1.101** (**BIG-IP #1**).

   .. image:: ./images/cfe-failover-verify-aws-2.png
      :align: left

   |

#. Switch to the browser tab with the example application and press **<CTRL-F5>** a few times to refresh the page.

   .. image:: ./images/cfe-failover-verify-web-3.png
      :align: left

