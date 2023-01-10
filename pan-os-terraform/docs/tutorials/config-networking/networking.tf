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

# Configure interfaces
resource "panos_ethernet_interface" "e1" {
  vsys        = "vsys1"
  name        = "ethernet1/1"
  mode        = "layer3"
  static_ips  = ["1.2.3.5/24"]
  enable_dhcp = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "panos_ethernet_interface" "e2" {
  vsys        = "vsys1"
  name        = "ethernet1/2"
  mode        = "layer3"
  static_ips  = ["172.16.18.1/24"]
  enable_dhcp = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "panos_ethernet_interface" "e3" {
  vsys        = "vsys1"
  name        = "ethernet1/3"
  mode        = "layer3"
  static_ips  = ["192.168.1.1/24"]
  enable_dhcp = false

  lifecycle {
    create_before_destroy = true
  }
}

# Create a virtual router
resource "panos_virtual_router" "vr1" {
  name = "new-vrouter"
  interfaces = [
    panos_ethernet_interface.e1.name,
    panos_ethernet_interface.e2.name,
    panos_ethernet_interface.e3.name,
  ]

  lifecycle {
    create_before_destroy = true
  }
}

# Create routes

resource "panos_static_route_ipv4" "defaultroute" {
  name           = "defaultroute"
  virtual_router = panos_virtual_router.vr1.name
  destination    = "0.0.0.0/0"
  interface      = "ethernet1/1"
  next_hop       = "1.2.3.1"

  lifecycle {
    create_before_destroy = true
  }
}

resource "panos_static_route_ipv4" "internalroute" {
  name           = "Internal subnet"
  virtual_router = panos_virtual_router.vr1.name
  destination    = "192.168.10.0/24"
  interface      = "ethernet1/3"
  next_hop       = "192.168.1.254"

  lifecycle {
    create_before_destroy = true
  }
}

# Configure security zones
resource "panos_zone" "internet" {
  name = "internet"
  mode = "layer3"
  interfaces = [
    panos_ethernet_interface.e1.name,
  ]
  enable_user_id = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "panos_zone" "dmz" {
  name = "dmz"
  mode = "layer3"
  interfaces = [
    panos_ethernet_interface.e2.name,
  ]
  enable_user_id = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "panos_zone" "users" {
  name = "users"
  mode = "layer3"
  interfaces = [
    panos_ethernet_interface.e3.name,
  ]
  enable_user_id = true

  lifecycle {
    create_before_destroy = true
  }
}
