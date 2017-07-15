resource "aws_cloudformation_stack" "f5-cluster-cross-az-ha-hourly" {
  name         = "ha-${var.emailidsan}-${aws_vpc.terraform-vpc.id}"
  capabilities = ["CAPABILITY_IAM"]

  parameters {
    #NETWORKING CONFIGURATION

    Vpc                          = "${aws_vpc.terraform-vpc.id}"
    managementSubnetAz1          = "${aws_subnet.f5-management-d.id}"
    managementSubnetAz2          = "${aws_subnet.f5-management-e.id}"
    bigipManagementSecurityGroup = "${aws_security_group.f5_management.id}"
    subnet1Az1                   = "${aws_subnet.public-d.id}"
    subnet1Az2                   = "${aws_subnet.public-e.id}"
    bigipExternalSecurityGroup   = "${aws_security_group.f5_data.id}"

    #INSTANCE CONFIGURATION

    imageName            = "Good25Mbps"
    instanceType         = "t2.medium"
    restrictedSrcAddress = "0.0.0.0/0"
    sshKey               = "${var.aws_keypair}"
    restrictedSrcAddress = "0.0.0.0/0"
    ntpServer            = "0.pool.ntp.org"

    #BIG-IQ LICENSING CONFIGURATION


    # bigiqAddress         = "${var.bigiqLicenseManager}"
    # bigiqUsername        = "admin"
    # bigiqPasswordS3Arn   = "arn:aws:s3:::f5-public-cloud/passwd"
    # bigiqLicensePoolName = "${var.bigiqLicensePoolName}"


    #TAGS

    application = "f5app"
    environment = "f5env"
    group       = "f5group"
    owner       = "f5owner"
    costcenter  = "f5costcenter"
  }

  #CloudFormation templates triggered from Terraform must be hosted on AWS S3. Experimental hosted in non-canonical S3 bucket.
  template_url = "https://s3.amazonaws.com/f5-cft/f5-existing-stack-across-az-cluster-hourly-2nic-bigip.template"
}
