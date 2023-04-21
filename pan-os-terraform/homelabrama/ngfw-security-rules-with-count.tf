resource "panos_security_rule_group" "rules" {
  count = 2001

  rule {
    name                  = "Rule_${count.index}"
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
