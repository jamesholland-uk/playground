terraform {
  required_providers {
    cloudngfwaws = {
      source  = "paloaltonetworks/cloudngfwaws"
      version = "1.0.8"
    }
  }
}


provider "cloudngfwaws" {
  host    = var.host
  region  = var.region
  # arn     = var.cloudngfw_iam_role // For firewall, rulestack, and global rulestack admin
  # gra_arn = var.cloudngfw_iam_role // For global rulestack admin
  lfa_arn = var.cloudngfw_iam_role // For firewall admin
  lra_arn = var.cloudngfw_iam_role // For rulestack admin
}

// ******************************************************************************************

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "host" {
  type    = string
  default = "api.us-east-1.aws.cloudngfw.paloaltonetworks.com"
}

variable "cloudngfw_iam_role" {
  type = string
  // This is the role created in the "01_iam_setup" folder
  // example: "arn:aws:iam::1234567890:role/CloudNGFWRole"
}

// ******************************************************************************************

resource "cloudngfwaws_commit_rulestack" "example" {
  rulestack = "terraform-rulestack"
}
