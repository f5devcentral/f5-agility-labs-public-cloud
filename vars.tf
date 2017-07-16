variable "bigiqLicenseManager" {
  description = "Management IP address of the BigIQ License Manager"
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

variable "emailid" {
  description = "emailid"
}

variable "emailidsan" {
  description = "emailidsan"
}

variable "restrictedSrcAddress" {
  type        = "list"
  description = "Lock down management access by source IP address or network"
  default     = ["0.0.0.0/0", "10.0.0.0/16"]
}

variable "aws_alias" {
  description = "Link alias to AWS Console"
}
