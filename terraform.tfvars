#Big-IQ 5.1 community ami is ami-96d59281

bigiq_ami = "ami-96d59281"

bigiqAddress = "${aws_resource.bigiq.public_ip}"

bigiqLicensePoolName = "bestLicPool"

server_port = 80

restrictedSrcAddress = "0.0.0.0/0"
