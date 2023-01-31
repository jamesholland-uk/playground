terraform {
  required_providers {
    cloudngfwaws = {
      source  = "paloaltonetworks/cloudngfwaws"
      version = "1.0.8"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5"
    }
  }
}

provider "aws" {
  region = var.region
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
}

variable "host" {
  type    = string
}

variable "aws_vpc_id" {
  type = string
}

variable "aws_dmz1_id" {
  type = string
}
variable "aws_dmz2_id" {
  type = string
}

variable "aws_vpc_rt_table" {
  type = string
}

variable "cloudngfw_iam_role" {
  type = string
  // This is the role created in the "01_iam_setup" folder
  // example: "arn:aws:iam::1234567890:role/CloudNGFWRole"
}

variable "aws_account_id" {
  type = string
  // example: "1234567890"
}

// ******************************************************************************************

resource "cloudngfwaws_rulestack" "example" {
  name        = "terraform-rulestack"
  scope       = "Local"
  account_id  = var.aws_account_id
  description = "Made by Terraform"
  profile_config {
    anti_spyware = "BestPractice"
  }
}

resource "cloudngfwaws_security_rule" "example" {
  rulestack   = cloudngfwaws_rulestack.example.name
  rule_list   = "LocalRule"
  priority    = 100
  name        = "example-security-rule"
  description = "Configured via Terraform"
  source {
    cidrs = ["any"]
  }
  destination {
    cidrs = ["10.1.1.0/24"]
  }
  applications = ["web-browsing"]
  protocol = "application-default"
  category {}
  action  = "Allow"
  logging = true
}

resource "cloudngfwaws_security_rule" "example2" {
  rulestack   = cloudngfwaws_rulestack.example.name
  rule_list   = "LocalRule"
  priority    = 105
  name        = "example-security-rule-2"
  description = "Configured via Terraform"
  source {
    cidrs = ["any"]
  }
  destination {
    cidrs = ["10.1.1.0/24"]
  }
  applications = ["web-browsing"]
  protocol = "application-default"
  category {}
  action  = "Allow"
  logging = true
}


resource "cloudngfwaws_ngfw" "example" {
  name        = "example-instance"
  vpc_id      = var.aws_vpc_id
  account_id  = var.aws_account_id
  description = "First NGFW resource"

  endpoint_mode = "ServiceManaged"
  subnet_mapping {
    subnet_id = var.aws_dmz1_id
  }
  subnet_mapping {
    subnet_id = var.aws_dmz2_id
  }

  rulestack = cloudngfwaws_rulestack.example.name

  tags = {
    foo = "bar"
  }
}

# resource "aws_route" "to_dmz1" {
#   route_table_id            = var.aws_vpc_rt_table
#   destination_cidr_block    = "10.0.1.0/24"
#   vpc_endpoint_id           = data.cloudngfwaws_ngfw.example.status[0].attachment[0].endpoint_id
# }

# resource "aws_route" "to_dmz2" {
#   route_table_id            = var.aws_vpc_rt_table
#   destination_cidr_block    = "10.0.2.0/24"
#   vpc_endpoint_id           = data.cloudngfwaws_ngfw.example.status[0].attachment[1].endpoint_id
# }

// ******************************************************************************************

data "cloudngfwaws_ngfw" "example" {
  name = "example-instance"
}

output "ngfw" {
  value = data.cloudngfwaws_ngfw.example.status
}
