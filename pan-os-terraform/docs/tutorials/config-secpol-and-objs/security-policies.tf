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

# Create address objects
resource "panos_address_object" "destination-server" {
  name        = "destination-server"
  value       = "192.168.80.5/32"
  description = "Address object 1 from Terraform"

  lifecycle {
    create_before_destroy = true
  }
}

resource "panos_address_object" "source-server" {
  name        = "source-server"
  value       = "192.168.120.8/32"
  description = "Address object 2 from Terraform"

  lifecycle {
    create_before_destroy = true
  }
}

# Create service objects
resource "panos_service_object" "tcp-12345" {
  name        = "12345-tcp"
  protocol    = "tcp"
  description = "Service object 1 from Terraform"

  lifecycle {
    create_before_destroy = true
  }
  destination_port = "12345"
}

resource "panos_service_object" "tcp-9876" {
  name        = "9876-tcp"
  protocol    = "tcp"
  description = "Service object 2 from Terraform"

  lifecycle {
    create_before_destroy = true
  }
  destination_port = "9876"
}

# Create security rules
resource "panos_security_rule_group" "example_ruleset" {
  position_keyword = "bottom"
  rule {
    name                  = "example rule 1"
    source_zones          = ["any"]
    source_addresses      = [panos_address_object.source-server.name]
    source_users          = ["any"]
    destination_zones     = ["any"]
    destination_addresses = [panos_address_object.destination-server.name]
    applications          = ["ssh"]
    services              = [panos_service_object.tcp-12345.name]
    categories            = ["any"]
    action                = "allow"
  }
  rule {
    name                  = "example rule 2"
    source_zones          = ["any"]
    source_addresses      = [panos_address_object.source-server.name]
    source_users          = ["any"]
    destination_zones     = ["any"]
    destination_addresses = [panos_address_object.destination-server.name]
    applications          = ["any"]
    services              = [panos_service_object.tcp-9876.name]
    categories            = ["any"]
    action                = "deny"
  }

  lifecycle {
    create_before_destroy = true
  }
}
