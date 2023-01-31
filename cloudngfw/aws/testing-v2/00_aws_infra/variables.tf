# Project Variables
variable "projectname" {
  type = string
}

# AWS Provider Variables
variable "aws_region" {
  type = string
}

variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

# VPC Variables
variable "vpc_supernet" {
  type = string
}

variable "dmz1_subnet" {
  type = string
}

variable "dmz2_subnet" {
  type = string
}

variable "cloudngfw_subnet" {
  type = string
}

variable "vpc_availability_zone" {
  type = string
}

# Host variables
variable "host1_ip" {
  type = string
}

variable "host2_ip" {
  type = string
}

variable "host_instance_type" {
  type = string
}
