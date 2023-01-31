terraform {
  required_providers {
    cloudngfwaws = {
      source  = "paloaltonetworks/cloudngfwaws"
      version = "1.0.8"
    }
  }
}

provider "cloudngfwaws" {
  host    = "api.${local.aws_region}.aws.cloudngfw.paloaltonetworks.com"
  region  = local.aws_region
  lfa_arn = local.cloudngfw_role_arn
  lra_arn = local.cloudngfw_role_arn
}
