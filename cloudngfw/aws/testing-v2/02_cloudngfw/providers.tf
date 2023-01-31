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

# Configure AWS Provider
provider "aws" {
  region     = local.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# Configure Cloud NGFW Provider
provider "cloudngfwaws" {
  host    = "api.${local.aws_region}.aws.cloudngfw.paloaltonetworks.com"
  region  = local.aws_region
  lfa_arn = local.cloudngfw_role_arn
  lra_arn = local.cloudngfw_role_arn
}
