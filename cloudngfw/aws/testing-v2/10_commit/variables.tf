# Build path to AWS Infrastructure's Terraform state
data "terraform_remote_state" "aws_infra" {
  backend = "local"
  config = {
    path = "../00_aws_infra/terraform.tfstate"
  }
}

# Build path to Cloud NGFW Rulestack's Terraform state
data "terraform_remote_state" "cloudngfw_rulestack" {
  backend = "local"
  config = {
    path = "../01_cloudngfw_rulestacks_rules/terraform.tfstate"
  }
}

# Variables - values retrieved from previous Terraform deployments, using the deployment states as declared above
locals {
  aws_region         = data.terraform_remote_state.aws_infra.outputs.aws_region
  cloudngfw_role_arn = data.terraform_remote_state.aws_infra.outputs.cloudngfw_role_arn
  rulestack_name     = data.terraform_remote_state.cloudngfw_rulestack.outputs.rulestack_name
}
