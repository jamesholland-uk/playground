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


# Define the data we want to gather, the rules in the security policy
data "panos_security_rules" "security_policy_rules" {}

# Output data for the rulebase in its entirety
output "security_policy_rules" {
  value = data.panos_security_rules.security_policy_rules
}

# Output the number of rules in the rulebase
output "number_of_security_rules" {
  value = data.panos_security_rules.security_policy_rules.total
}

# Output just the names of the rules 
output "security_policy_rulenames" {
  value = data.panos_security_rules.security_policy_rules.listing
}


# Use the names of the rules from the previous data gathering, and gather the detailed information for each rule
data "panos_security_rule" "example" {
  for_each = toset(data.panos_security_rules.security_policy_rules.listing)
  name     = each.key
}

# Out the detailed information of each rule in the rulebase
output "rule_output" {
  value = data.panos_security_rule.example
}
