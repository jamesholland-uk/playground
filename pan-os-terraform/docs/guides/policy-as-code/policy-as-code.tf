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
  hostname = var.panos_hostname
  username = var.panos_username
  password = var.panos_password
}

variable "panos_hostname" {
  type = string
}

variable "panos_username" {
  type = string
}

variable "panos_password" {
  type = string
}

# Create a Device Group
resource "panos_panorama_device_group" "dg1" {
  name        = "policy-as-code"
  description = "example device group for policy as code demo"
}

# Create an Anti-Virus Security Profile
resource "panos_antivirus_security_profile" "av1" {
  name         = "AV Protection"
  device_group = panos_panorama_device_group.dg1.name
  description  = "Example AV profile"

  decoder { name = "smtp" }
  decoder { name = "smb" }
  decoder { name = "pop3" }
  decoder { name = "imap" }
  decoder {
    name   = "http"
    action = "reset-both"
  }
  decoder { name = "http2" }
  decoder {
    name   = "ftp"
    action = "reset-both"
  }
}

# Create rules based on a YAML input file
resource "panos_panorama_security_rule_group" "this" {

  device_group = panos_panorama_device_group.dg1.name

  dynamic "rule" {
    for_each = { for key, policy in yamldecode(file("./policy.yml")).security_policies : format("%.4d", key) => policy }
    content {
      name                  = rule.value.name
      source_zones          = lookup(rule.value, "source_zones", ["any"])
      source_addresses      = lookup(rule.value, "source_addresses", ["any"])
      source_users          = lookup(rule.value, "source_users", ["any"])
      destination_zones     = lookup(rule.value, "destination_zones", ["any"])
      destination_addresses = lookup(rule.value, "destination_addresses", ["any"])
      applications          = lookup(rule.value, "applications", ["any"])
      services              = lookup(rule.value, "services", ["application-default"])
      categories            = lookup(rule.value, "categories", ["any"])
      virus                 = panos_antivirus_security_profile.av1.name
      action                = lookup(rule.value, "action", "allow")
    }
  }
}
