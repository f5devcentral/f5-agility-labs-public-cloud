variable "bigiq_ami" {
  description = "BigIQ ami to launch"
}

variable "bigiqAddress" {
  description = "Management IP address of the BigIQ License Server"
}

variable "bigiqLicensePoolName" {
  description = "BigIQ License Pool name"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
}

variable "aws_keypair" {
  description = "The name of an existing key pair. In AWS Console: NETWORK & SECURITY -> Key Pairs"
}

variable "licenseKey1" {
  description = "license key 1"
}

variable "licenseKey2" {
  description = "license key 2"
}

variable "bigiqLicense" {
  description = "BigIQ base license key"
}

variable "emailid" {
  description = "emailid"
}

variable "emailidsan" {
  description = "emailidsan"
}

variable "restrictedSrcAddress" {
  description = "Lock down management access by source IP address or network"
  default     = "0.0.0.0/0"
}
