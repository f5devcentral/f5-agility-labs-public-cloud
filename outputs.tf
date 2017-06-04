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
