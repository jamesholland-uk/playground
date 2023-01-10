# Define required Terraform providers
terraform {
  required_providers {
    panos = {
      source  = "paloaltonetworks/panos"
      version = "~> 1.11.0"
    }
  }
}

# Configure the PAN-OS provider for Terraform
provider "panos" {
  json_config_file = "../../../auth-vm-series-beta.json"
}

# Define the data we want to gather, the PAN-OS "system info"
data "panos_system_info" "ngfw_info" {}

# Output the data
output "the_info" {
  value = data.panos_system_info.ngfw_info
}
