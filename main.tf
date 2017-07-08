terraform {
  required_version = ">=0.9.6"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "terraform-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"

  tags {
    Name = "terraform_${var.emailid}"
  }

  #With timestamp
  /*
    tags {
    Name = "terraform_${var.emailid}_${timestamp()}"
  }
  */
}

resource "aws_subnet" "f5-management-d" {
  vpc_id                  = "${aws_vpc.terraform-vpc.id}"
  cidr_block              = "10.0.101.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1d"

  tags {
    Name = "management"
  }
}

resource "aws_subnet" "f5-management-e" {
  vpc_id                  = "${aws_vpc.terraform-vpc.id}"
  cidr_block              = "10.0.102.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1e"

  tags {
    Name = "management"
  }
}

resource "aws_subnet" "public-d" {
  vpc_id                  = "${aws_vpc.terraform-vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1d"

  tags {
    Name = "public"
  }
}

resource "aws_subnet" "private-d" {
  vpc_id                  = "${aws_vpc.terraform-vpc.id}"
  cidr_block              = "10.0.100.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1d"

  tags {
    Name = "private"
  }
}

resource "aws_subnet" "public-e" {
  vpc_id                  = "${aws_vpc.terraform-vpc.id}"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1e"

  tags {
    Name = "public"
  }
}

resource "aws_subnet" "private-e" {
  vpc_id                  = "${aws_vpc.terraform-vpc.id}"
  cidr_block              = "10.0.200.0/24"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1e"

  tags {
    Name = "private"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.terraform-vpc.id}"

  tags {
    Name = "internet-gateway"
  }
}

resource "aws_route_table" "rt1" {
  vpc_id = "${aws_vpc.terraform-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "Default"
  }
}

resource "aws_main_route_table_association" "association-subnet" {
  vpc_id         = "${aws_vpc.terraform-vpc.id}"
  route_table_id = "${aws_route_table.rt1.id}"
}

/*
resource "aws_launch_configuration" "example" {
  image_id        = "ami-40d28157"
  instance_type   = "t2.micro"
  key_name        = "${var.aws_keypair}"
  security_groups = ["${aws_security_group.instance.id}"]

  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  launch_configuration = "${aws_launch_configuration.example.id}"
  vpc_zone_identifier  = ["${aws_subnet.public-d.id}", "${aws_subnet.public-e.id}"]

  load_balancers    = ["${aws_elb.example.name}"]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "tf-asg-elb-${var.emailid}"
    propagate_at_launch = true
  }
}
*/

resource "aws_security_group" "instance" {
  name   = "terraform-example-instance"
  vpc_id = "${aws_vpc.terraform-vpc.id}"

  ingress {
    from_port   = "${var.server_port}"
    to_port     = "${var.server_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "example-d" {
  count                  = 1
  ami                    = "ami-40d28157"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.public-d.id}"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  key_name               = "${var.aws_keypair}"

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags {
    Name        = "web-az1.${count.index}"
    application = "f5app"
    environment = "f5env"
    group       = "f5group"
    owner       = "f5owner"
    costcenter  = "f5costcenter"
  }
}

resource "aws_instance" "example-e" {
  count                  = 1
  ami                    = "ami-40d28157"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.public-e.id}"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  key_name               = "${var.aws_keypair}"

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags {
    Name        = "web-az2.${count.index}"
    application = "f5app"
    environment = "f5env"
    group       = "f5group"
    owner       = "f5owner"
    costcenter  = "f5costcenter"
  }
}

#data "aws_availability_zones" "all" {}

resource "aws_iam_server_certificate" "elb_cert" {
  name             = "elb_cert_${var.emailid}"
  certificate_body = "${file("${var.emailidsan}.crt")}"
  private_key      = "${file("${var.emailidsan}.key")}"
}

resource "aws_elb" "example" {
  name = "tf-elb-${var.emailidsan}"

  cross_zone_load_balancing = true
  security_groups           = ["${aws_security_group.elb.id}"]
  subnets                   = ["${aws_subnet.public-d.id}", "${aws_subnet.public-e.id}"]

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "${var.server_port}"
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:${var.server_port}/"
  }

  instances                   = ["${aws_instance.example-d.id}", "${aws_instance.example-e.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "tf-elb-${var.emailidsan}"
  }
}

resource "aws_security_group" "elb" {
  name   = "terraform-example-elb"
  vpc_id = "${aws_vpc.terraform-vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.restrictedSrcAddress}"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.restrictedSrcAddress}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "f5_management" {
  name   = "f5_management"
  vpc_id = "${aws_vpc.terraform-vpc.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.restrictedSrcAddress}"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.restrictedSrcAddress}"
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = "${var.restrictedSrcAddress}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "f5_data" {
  name   = "f5_data"
  vpc_id = "${aws_vpc.terraform-vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.restrictedSrcAddress}"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.restrictedSrcAddress}"
  }

  ingress {
    from_port   = 1026
    to_port     = 1026
    protocol    = "udp"
    cidr_blocks = "${var.restrictedSrcAddress}"
  }

  ingress {
    from_port   = 4353
    to_port     = 4353
    protocol    = "tcp"
    cidr_blocks = "${var.restrictedSrcAddress}"
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = "${var.restrictedSrcAddress}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
