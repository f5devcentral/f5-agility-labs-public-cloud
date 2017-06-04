output "elb_dns_name" {
  value = "${aws_elb.example.dns_name}"
}

output "vpc-id" {
  value = "${aws_vpc.terraform-vpc.id}"
}

output "vpc-public-d" {
  value = "${aws_subnet.public-d.cidr_block}"
}

output "vpc-public-d-id" {
  value = "${aws_subnet.public-d.id}"
}

output "vpc-private-d" {
  value = "${aws_subnet.private-d.cidr_block}"
}

output "vpc-private-d-id" {
  value = "${aws_subnet.private-d.id}"
}

output "vpc-public-e" {
  value = "${aws_subnet.public-d.cidr_block}"
}

output "vpc-public-e-id" {
  value = "${aws_subnet.public-d.id}"
}

output "vpc-private-e" {
  value = "${aws_subnet.private-d.cidr_block}"
}

output "vpc-private-e-id" {
  value = "${aws_subnet.private-d.id}"
}

output "sshKey" {
  value = "${key_pair}"
}

output "bigipExternalSecurityGroup" {
  value = "${aws_security_group.elb.id}"
}

output "bigipManagementSecurityGroup" {
  value = "${aws_security_group.f5_management.id}"
}

output "licenseKey1" {
  value = "DUQVK-SIYYP-WTCHG-VHRFG-JLSFYQF"
}

output "licenseKey2" {
  value = "LOXBY-PQCUE-TUAHN-TSRHU-USSTGLH"
}

output "managementSubnetAz1" {
  value = "${aws_subnet.f5-management-d.id}"
}

output "managementSubnetAz2" {
  value = "${aws_subnet.f5-management-e.id}"
}

output "restrictedSrcAddress" {
  value = "0.0.0.0/0"
}
