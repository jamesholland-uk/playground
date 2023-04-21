resource "panos_security_rule_group" "rules" {
  rule {
    name                  = "Rule"
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

  lifecycle {
    create_before_destroy = true
  }
}
