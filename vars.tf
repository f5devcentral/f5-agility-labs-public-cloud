variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default     = 8080
}

variable "key_pair" {
  description = "The name of an existing key pair. In AWS Console: NETWORK & SECURITY -> Key Pairs"
  type        = "string"
  default     = "MyKeyPair"
}

variable "licenseKey1" {
  description = "license key 1"
  type        = "string"
  default     = "DUQVK-SIYYP-WTCHG-VHRFG-JLSFYQF"
}

variable "licenseKey2" {
  description = "license key 2"
  type        = "string"
  default     = "LOXBY-PQCUE-TUAHN-TSRHU-USSTGLH"
}
