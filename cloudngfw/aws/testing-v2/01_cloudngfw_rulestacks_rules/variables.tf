# Build path to AWS Infrastructure's Terraform state
data "terraform_remote_state" "aws_infra" {
  backend = "local"
  config = {
    path = "../00_aws_infra/terraform.tfstate"
  }
}

# Variables - values retrieved from previous Terraform deployment, using the deployment's state as declared above
locals {
  projectname        = data.terraform_remote_state.aws_infra.outputs.projectname
  aws_account_id     = data.terraform_remote_state.aws_infra.outputs.aws_account_id
  aws_region         = data.terraform_remote_state.aws_infra.outputs.aws_region
  cloudngfw_role_arn = data.terraform_remote_state.aws_infra.outputs.cloudngfw_role_arn
  host1_private_ip   = data.terraform_remote_state.aws_infra.outputs.host1_private_ip
  host2_private_ip   = data.terraform_remote_state.aws_infra.outputs.host2_private_ip
}
