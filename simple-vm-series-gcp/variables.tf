variable "project" {}
variable "region" {}
variable "name_prefix" {
  default = "example-"
}
variable "vmseries" {}
variable "vmseries_common" {}
variable "allowed_sources" {}
variable "ssh_keys" {}
variable "mgmt_cidr_range" {
  default  = "10.236.64.0/28"
}
variable "outside_cidr_range" {
  default  = "10.236.64.16/28"
}
variable "inside_cidr_range" {
  default  = "10.236.64.32/28"
}
variable bootstrap_data {}