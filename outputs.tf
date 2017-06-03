output "elb_dns_name" {
  value = "${aws_elb.example.dns_name}"
}

output "vpc-id" {
  value = "${aws_vpc.terraform-vpc.id}"
}

output "vpc-publicsubnet" {
  value = "${aws_subnet.public-d.cidr_block}"
}

output "vpc-publicsubnet-id" {
  value = "${aws_subnet.public-e.id}"
}

output "vpc-privatesubnet" {
  value = "${aws_subnet.private-d.cidr_block}"
}

output "vpc-privatesubnet-id" {
  value = "${aws_subnet.private-e.id}"
}
