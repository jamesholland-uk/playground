resource "panos_address_object" "terraform-address-object" {
  name        = "terraform-address-object"
  value       = "192.168.80.1/32"
  description = "Addres object from Terraform"
}

resource "panos_panorama_security_rule_group" "extra-rules" {
  device_group = "poc-dg"
  rule {
    name                  = "rule 3"
    source_zones          = ["inside"]
    source_addresses      = ["any"]
    source_users          = ["any"]
    destination_zones     = ["outside"]
    destination_addresses = ["any"]
    applications          = ["any"]
    services              = ["application-default"]
    categories            = ["any"]
    action                = "allow"
  }
  rule {
    name                  = "rule 4"
    source_zones          = ["outside"]
    source_addresses      = ["any"]
    source_users          = ["any"]
    destination_zones     = ["inside"]
    destination_addresses = ["any"]
    applications          = ["any"]
    services              = ["application-default"]
    categories            = ["any"]
    action                = "deny"
  }
}
