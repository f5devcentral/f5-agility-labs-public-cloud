resource "aws_instance" "bigiq" {
  count                       = 1
  ami                         = "${var.bigiq_ami}"
  instance_type               = "m4.large"
  subnet_id                   = "${aws_subnet.public-e.id}"
  vpc_security_group_ids      = ["${aws_security_group.f5_management.id}"]
  key_name                    = "${var.aws_keypair}"
  associate_public_ip_address = true

  /* Doesn't work
    user_data = <<-EOF
                #!/bin/bash
                /usr/local/bin/SOAPLicenseClient --verbose --basekey "FPNUN-AEFULU-GFZ-MDBKYPZ-HXIKMWV"
                EOF
  */
  tags {
    Name = "f5-bigiq-5.1"
  }
}
