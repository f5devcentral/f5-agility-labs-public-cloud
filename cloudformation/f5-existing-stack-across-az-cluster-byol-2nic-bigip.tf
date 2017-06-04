/*
resource "aws_cloudformation_stack" "f5-cluster" {
  name = "f5-cluster"

  parameters {
    Vpc                          = "${aws_vpc.terraform-vpc.id}"
    bigipExternalSecurityGroup   = "${aws_security_group.elb.id}"
    bigipManagementSecurityGroup = "${aws_security_group.f5_management.id}"
    imageName                    = "Best"
    licenseKey1                  = "DUQVK-SIYYP-WTCHG-VHRFG-JLSFYQF"
    licenseKey2                  = "LOXBY-PQCUE-TUAHN-TSRHU-USSTGLH"
    managementSubnetAz1          = "${aws_subnet.f5-management-d.id}"
    managementSubnetAz2          = "${aws_subnet.f5-management-e.id}"
    restrictedSrcAddress         = "0.0.0.0/0"
    sshKey                       = "${key_pair}"
    subnet1Az1                   = "${aws_subnet.public-d.id}"
    subnet1Az2                   = "${aws_subnet.public-e.id}"
  }

  template_url = "https://github.com/F5Networks/f5-aws-cloudformation/blob/master/supported/cluster/2nic/across-az-ha/f5-existing-stack-across-az-cluster-byol-2nic-bigip.template"
}
*/