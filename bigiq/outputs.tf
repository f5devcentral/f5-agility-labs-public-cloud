output "Big-IQ License Manager public IP" {
  value = "${aws_instance.bigiq.public_ip}"
}

output "BIG-IQ License Manager dns name" {
  value = "${aws_instance.bigiq.public_dns}"
}

output "Big-IQ License Manager key name" {
  value = "${aws_instance.bigiq.key_name}"
}

output "vpc-id" {
  value = "${aws_vpc.terraform-vpc.id}"
}
