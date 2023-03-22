Delete the AWS Deployment (Terraform)
================================================================================

The |destroy_link| command deletes the resources that were created by the Terraform configuration.

In the BASH Terminal, execute the following:

   .. code-block:: bash

      cd ~/sslo-cloud-templates/terraform-aws-sslo
      terraform destroy -auto-approve

You will see output similar to the following:

   .. code-block:: bash

      tls_private_key.my_keypair: Refreshing state... [id=dd2ac4e60611c9dd8dfd28d2f5fb10505f9f168c]
      local_file.public_key: Refreshing state... [id=cb9a2ab11f99c8b3a6508e93bb9e0a1a3119c583]
      local_file.private_key: Refreshing state... [id=24b972912755b39841b454ba430505235cd79159]
      aws_key_pair.my_keypair: Refreshing state... [id=sslo-keypair]
      aws_ec2_transit_gateway.sslo: Refreshing state... [id=tgw-0a5b0926c6a1a09ce]
      aws_vpc.securitystack: Refreshing state... [id=vpc-09100cffab627853e]
      aws_vpc.appstack: Refreshing state... [id=vpc-056c926e73ad06ec8]

      <...>

      Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
      following symbols:
      - destroy

      <...>

      # aws_instance.sslo will be destroyed
      - resource "aws_instance" "sslo" {
            - ami                                  = "ami-08825101a0ab709f0" -> null
            - arn                                  = "arn:aws:ec2:us-east-1:595963691893:instance/i-03c30c9e721fd34b7" -> null
            - associate_public_ip_address          = true -> null
            - availability_zone                    = "us-east-1a" -> null

      <...>

      Plan: 0 to add, 0 to change, 61 to destroy.

      Changes to Outputs:
      - inspection_service_ip_1    = "10.0.3.21" -> null
      - inspection_service_ip_2    = "10.0.4.21" -> null

      <...>

      local_file.private_key: Destroying... [id=24b972912755b39841b454ba430505235cd79159]
      local_file.ansible_vars: Destroying... [id=78ed3e74e8a8f3a3dabbbd498c36966fedac971a]
      local_file.public_key: Destroying... [id=cb9a2ab11f99c8b3a6508e93bb9e0a1a3119c583]
      local_file.private_key: Destruction complete after 0s
      local_file.public_key: Destruction complete after 0s
      local_file.ansible_vars: Destruction complete after 0s
      aws_ec2_transit_gateway_vpc_attachment.appstack: Destroying... [id=tgw-attach-04728d9791b8e5337]
      aws_route_table_association.dmz1: Destroying... [id=rtbassoc-00eba776bcffd6458]
      aws_route_table_association.external: Destroying... [id=rtbassoc-04288cfe812ccd8b9]
      aws_ec2_transit_gateway_route.return_public_ip: Destroying... [id=tgw-rtb-0b87e7316dcc27c9c_0.0.0.0/0]
      aws_ec2_transit_gateway_route_table.sslo: Destroying... [id=tgw-rtb-0b0fd834c7241ce93]
      aws_route_table_association.dmz4: Destroying... [id=rtbassoc-0883b86d8c97417c4]
      aws_route_table_association.application: Destroying... [id=rtbassoc-01e2a7d24d4924db8]
      aws_route_table_association.dmz3: Destroying... [id=rtbassoc-0b59903da2b9fccd3]
      aws_instance.inspection_device_1: Destroying... [id=i-0380c7c5ab552c64e]
      aws_instance.sslo: Destroying... [id=i-03c30c9e721fd34b7]

      <...>

      aws_instance.sslo: Destruction complete after 52s

      <...>

      aws_ec2_transit_gateway.sslo: Still destroying... [id=tgw-0a5b0926c6a1a09ce, 1m0s elapsed]
      aws_ec2_transit_gateway.sslo: Destruction complete after 1m7s

      Destroy complete! Resources: 61 destroyed.

Return to the **AWS Console** dashboards to confirm that your **EC2 Instances** and **VPCs** were deleted.

|



.. |destroy_link| raw:: html

      <a href="https://www.terraform.io/cli/commands/destroy" target="_blank"> destroy </a>

