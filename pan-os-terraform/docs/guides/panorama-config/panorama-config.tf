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
  type    = string
  default = "192.168.1.1"
}

variable "panos_username" {
  type    = string
  default = "admin"
}

variable "panos_password" {
  type    = string
  default = "admin"
}

# Create Device Group
resource "panos_device_group" "dg1" {
  name        = "Lab-DG"
  description = "Device Group for Lab Purposes"

  lifecycle {
    create_before_destroy = true
  }
}

#Create Template and Stack
resource "panos_panorama_template" "tpl1" {
  name        = "Lab-TPL"
  description = "Template for Lab Purposes"

  lifecycle {
    create_before_destroy = true
  }
}

resource "panos_panorama_template_stack" "tplstack1" {
  name        = "Lab-TPL-Stack"
  description = "Template Stack for Lab Purposes"
  templates   = [panos_panorama_template.tpl1.name]

  lifecycle {
    create_before_destroy = true
  }
}

# Configure Interfaces
resource "panos_panorama_ethernet_interface" "e1" {
  vsys        = "vsys1"
  name        = "ethernet1/1"
  mode        = "layer3"
  static_ips  = ["1.2.3.5/24"]
  enable_dhcp = false
  template    = panos_panorama_template.tpl1.name

  lifecycle {
    create_before_destroy = true
  }
}

resource "panos_panorama_ethernet_interface" "e2" {
  vsys        = "vsys1"
  name        = "ethernet1/2"
  mode        = "layer3"
  static_ips  = ["172.16.18.1/24"]
  enable_dhcp = false
  template    = panos_panorama_template.tpl1.name

  lifecycle {
    create_before_destroy = true
  }
}

# Create a Virtual Router
resource "panos_virtual_router" "vr1" {
  name = "new-vrouter"
  interfaces = [
    panos_panorama_ethernet_interface.e1.name,
    panos_panorama_ethernet_interface.e2.name,
  ]
  template = panos_panorama_template.tpl1.name

  lifecycle {
    create_before_destroy = true
  }
}

# Create Default Route
resource "panos_panorama_static_route_ipv4" "defaultroute" {
  name           = "DefaultRoute"
  virtual_router = panos_virtual_router.vr1.name
  destination    = "0.0.0.0/0"
  interface      = panos_panorama_ethernet_interface.e1.name
  next_hop       = "1.2.3.1"
  template       = panos_panorama_template.tpl1.name

  lifecycle {
    create_before_destroy = true
  }
}

# Configure Security Zones
resource "panos_zone" "internet" {
  name = "internet"
  mode = "layer3"
  interfaces = [
    panos_panorama_ethernet_interface.e1.name,
  ]
  enable_user_id = false
  template       = panos_panorama_template.tpl1.name

  lifecycle {
    create_before_destroy = true
  }
}

resource "panos_zone" "dmz" {
  name = "dmz"
  mode = "layer3"
  interfaces = [
    panos_panorama_ethernet_interface.e2.name,
  ]
  enable_user_id = false
  template       = panos_panorama_template.tpl1.name

  lifecycle {
    create_before_destroy = true
  }
}

#Create Address Objects and Group
resource "panos_address_object" "addobj1" {
  name         = "AddressObject-1"
  value        = "192.168.1.1/32"
  device_group = panos_device_group.dg1.name

  lifecycle {
    create_before_destroy = true
  }
}

resource "panos_address_object" "addobj2" {
  name         = "AddressObject-2"
  value        = "192.168.1.2/32"
  device_group = panos_device_group.dg1.name

  lifecycle {
    create_before_destroy = true
  }
}

resource "panos_panorama_address_group" "addgrp1" {
  name = "AddressGroup-1"
  static_addresses = [
    panos_address_object.addobj1.name,
    panos_address_object.addobj2.name,
  ]
  device_group = panos_device_group.dg1.name

  lifecycle {
    create_before_destroy = true
  }
}

# Create Security Policy Rules
resource "panos_security_policy" "rules" {
  rule {
    name                  = "Rule-1"
    audit_comment         = "Initial config"
    source_zones          = [panos_zone.dmz.name]
    source_addresses      = [panos_panorama_address_group.addgrp1.name]
    source_users          = ["any"]
    destination_zones     = [panos_zone.internet.name]
    destination_addresses = ["any"]
    applications          = ["ssh"]
    services              = ["application-default"]
    categories            = ["any"]
    action                = "allow"
  }
  rule {
    name                  = "Rule-2"
    audit_comment         = "Initial config"
    source_zones          = [panos_zone.dmz.name]
    source_addresses      = [panos_panorama_address_group.addgrp1.name]
    source_users          = ["any"]
    destination_zones     = [panos_zone.internet.name]
    destination_addresses = ["any"]
    applications          = ["any"]
    services              = ["any"]
    categories            = ["any"]
    action                = "deny"
  }
  device_group = panos_device_group.dg1.name
  rulebase     = "post-rulebase"

  lifecycle {
    create_before_destroy = true
  }
}
