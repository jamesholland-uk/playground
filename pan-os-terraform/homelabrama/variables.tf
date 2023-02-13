variable "panos_hostname" {
  type    = string
  default = "192.168.1.1"
}

variable "panos_username" {
  type    = string
  default = "admin"
}

variable "panos_password" {
  type    = string
  default = "admin"
}

variable "panorama_template" {
  type    = string
  default = ""
}

variable "ike_psk1" {
  type    = string
  default = ""
}

variable "ike_psk2" {
  type    = string
  default = ""
}

variable "awspeer1" {
  type    = string
  default = ""
}

variable "awspeer2" {
  type    = string
  default = ""
}

variable "aws_region" {
  type    = string
  default = "admin"
}

variable "aws_access_key" {
  type    = string
  default = "admin"
}

variable "aws_secret_key" {
  type    = string
  default = "admin"
}
