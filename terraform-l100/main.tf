terraform {
  required_providers {
    panos = {
      source = "paloaltonetworks/panos"
    }
  }
}

provider "panos" {
}

resource "panos_zone" "internetzone" {
  name       = "internet"
  mode       = "layer3"
  interfaces = [panos_ethernet_interface.eth1.name]
}

resource "panos_ethernet_interface" "eth1" {
  name                      = "ethernet1/1"
  vsys                      = "vsys1"
  mode                      = "layer3"
  enable_dhcp               = false
  static_ips                = ["10.1.1.1/24"]
}

resource "panos_address_object" "web" {
  name  = "web-srv"
  value = "10.5.2.10"
}
resource "panos_service_object" "tcp_222" {
  name             = "service-tcp-222"
  protocol         = "tcp"
  destination_port = "222"
}

resource "panos_security_policy" "security-rule" {
  rule {
    name                  = "Allow SSH on tcp-222"
    source_zones          = ["any"]
    source_addresses      = [panos_address_object.web.name]
    source_users          = ["any"]
    hip_profiles          = ["any"]
    destination_zones     = [panos_zone.internetzone.name]
    destination_addresses = ["any"]
    applications          = ["ssh"]
    services              = [panos_service_object.tcp_222.name]
    categories            = ["any"]
    action                = "allow"
  }
}

resource "null_resource" "commit_job" {
    provisioner "local-exec" {
        command = "./commit" panos.hostname 
    }
    depends_on = [
        panos_security_policy.security-rule
    ]
}
