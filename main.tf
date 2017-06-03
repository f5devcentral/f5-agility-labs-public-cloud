terraform {
  required_version = ">= 0.8, < 0.9.7"
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
    Name = "terraform"
  }
}

resource "aws_subnet" "public-d" {
  vpc_id                  = "${aws_vpc.terraform-vpc.id}"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
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
  map_public_ip_on_launch = "true"
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

resource "aws_route_table_association" "association-subnet" {
  subnet_id      = "${aws_subnet.public-d.id}"
  route_table_id = "${aws_route_table.rt1.id}"
}

resource "aws_launch_configuration" "example" {
  image_id        = "ami-40d28157"
  instance_type   = "t2.micro"
  key_name        = "${var.key_pair}"
  security_groups = ["${aws_security_group.instance.id}"]

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
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}

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

  lifecycle {
    create_before_destroy = true
  }
}

/*
resource "aws_instance" "example" {
  ami                    = "ami-40d28157"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.private-d.id}"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
              EOF

  tags {
    Name = "terraform-example"
  }
}

*/
data "aws_availability_zones" "all" {}

resource "aws_elb" "example" {
  name = "terraform-asg-example"

  #availability_zones = ["us-east-1d", "us-east-1e"]
  security_groups = ["${aws_security_group.elb.id}"]
  subnets         = ["${aws_subnet.private-d.id}", "${aws_subnet.private-e.id}"]

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
}

resource "aws_security_group" "elb" {
  name   = "terraform-example-elb"
  vpc_id = "${aws_vpc.terraform-vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
