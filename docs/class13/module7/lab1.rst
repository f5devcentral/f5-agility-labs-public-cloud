Delete the AWS Deployment (Terraform)
================================================================================

The |destroy_link| command deletes the resources that were created by the Terraform configuration.

In the BASH terminal, execute the following:

   .. code-block:: bash

      cd ~/f5lab/terraform
      terraform destroy -auto-approve

|

You will see output similar to the following:

   .. code-block:: bash

      <...>

      aws_vpc.hub-vpc will be destroyed

      <...>

      Plan: 0 to add, 0 to change, 62 to destroy.

      Changes to Outputs:
        - AWS_CONSOLE_LINK                = "https://xxxxxxxxxxxx.signin.aws.amazon.com/console" -> null
        - AWS_PASSWORD                    = "xY&+66d6vt|18Wz{@NbM2(WQ" -> null
        - AWS_USER                        = "udf" -> null
        - appsvr1_private_address         = "10.1.200.80" -> null

      <...>

      local_file.private_key: Destroying... [id=beec5b41fb9db2c1cd0ac08e8457c58c5b1d7554]
      local_file.public_key: Destroying... [id=12290914a11c8d9be3024351ba651c1ca4541ac0]
      local_file.bigip1_f5_onboard[0]: Destroying... [id=f4ca0b22ac91241af1ad6ee89823fc7c2627313c]
      local_file.postman_rendered: Destroying... [id=f10076fa7736f4367d6225a9de9cdf32eeea63be]
      <...>
      aws_ec2_transit_gateway_route_table.tgw-rt: Destroying... [id=tgw-rtb-01dc2576175cb662f]
      aws_eip.bigip2_mgmt: Destroying... [id=eipalloc-08296c0935f1553de]
      aws_eip.bigip1_mgmt: Destroying... [id=eipalloc-0ceabadf16a47cece]
      aws_instance.appsvr2: Destroying... [id=i-0ae7461b4accdb8ac]
      aws_instance.bigip1: Destroying... [id=i-0fb93f4269d639456]
      aws_instance.bigip2: Destroying... [id=i-0e2742738f3e1840d]
      <...>
      aws_instance.appsvr1: Still destroying... [id=i-04c5ca91df6ebdc13, 10s elapsed]
      aws_instance.bigip2: Destruction complete after 20s
      <...>
      aws_instance.bigip1: Destruction complete after 29s
      <...>
      aws_instance.appsvr2: Still destroying... [id=i-0ae7461b4accdb8ac, 30s elapsed]
      aws_instance.appsvr2: Destruction complete after 30s
      aws_instance.appsvr1: Destruction complete after 30s
      <...>
      aws_ec2_transit_gateway.tgw: Still destroying... [id=tgw-096ce265d857281bc, 2m0s elapsed]
      aws_ec2_transit_gateway.tgw: Destruction complete after 2m4s

      Destroy complete! Resources: 62 destroyed.

|

Return to the **AWS Console** dashboards to confirm that your **EC2 Instances** and **VPCs** were deleted.

|



.. |destroy_link| raw:: html

      <a href="https://www.terraform.io/cli/commands/destroy" target="_blank"> destroy </a>

