variable "bigiq_ami" {
  description = "BigIQ ami to launch"
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
