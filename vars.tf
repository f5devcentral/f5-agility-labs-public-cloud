variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default     = 8080
}

variable "key_pair" {
  description = "The name of an existing key pair. In AWS Console: NETWORK & SECURITY -> Key Pairs"
  default     = "MyKeyPair"
}

variable "licenseKey1" {
  description = "license key 1"
  default     = "11111-11111-11111-11111-11111-11111"
}

variable "licenseKey2" {
  description = "license key 2"
  default     = "22222-22222-22222-22222-22222-22222"
}
