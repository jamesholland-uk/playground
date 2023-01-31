# AWS Provider Variables
variable "aws_access_key" {
  type = string
}

variable "aws_secret_key" {
  type = string
}

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

# Variables - values retrieved from previous Terraform deployment, using the deployment's state as declared above
locals {
  projectname            = data.terraform_remote_state.aws_infra.outputs.projectname
  aws_account_id         = data.terraform_remote_state.aws_infra.outputs.aws_account_id
  aws_region             = data.terraform_remote_state.aws_infra.outputs.aws_region
  aws_vpc_id             = data.terraform_remote_state.aws_infra.outputs.vpc_id
  cloudngfw_role_arn     = data.terraform_remote_state.aws_infra.outputs.cloudngfw_role_arn
  cloudngfw_subnet_id    = data.terraform_remote_state.aws_infra.outputs.cloudngfw_subnet_id
  dmz1_subnet_cidr_block = data.terraform_remote_state.aws_infra.outputs.dmz1_subnet_cidr_block
  dmz2_subnet_cidr_block = data.terraform_remote_state.aws_infra.outputs.dmz2_subnet_cidr_block
  dmz1_routetable_id     = data.terraform_remote_state.aws_infra.outputs.dmz1_routetable_id
  dmz2_routetable_id     = data.terraform_remote_state.aws_infra.outputs.dmz2_routetable_id
  rulestack_name         = data.terraform_remote_state.cloudngfw_rulestack.outputs.rulestack_name
  cloudwatch_log_group   = data.terraform_remote_state.aws_infra.outputs.cloudwatch_log_group
}
