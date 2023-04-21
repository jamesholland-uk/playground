resource "panos_nat_rule_group" "bot" {
  # device_group = "lab-vm-series"
  # rulebase = "post-rulebase"
  rule {
    name          = "second"
    audit_comment = "Initial config"
    original_packet {
      source_zones          = ["outside"]
      destination_zone      = "outside"
      destination_interface = "ethernet1/2"
      source_addresses      = ["any"]
      destination_addresses = ["any"]
    }
    translated_packet {
      source {}
      destination {
        static_translation {
          address = "10.2.3.1"
          port    = 5678
        }
      }
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}
