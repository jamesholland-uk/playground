resource "sase_objects_addresses" "test_terraform_01" {
  folder      = "Shared"
  name        = "test-obj-01-terraform"
  description = "From Terraform Provider"
  ip_netmask  = "10.10.10.1"
}

resource "sase_objects_addresses" "test_terraform_02" {
  folder      = "Shared"
  name        = "test-obj-02-terraform"
  description = "From Terraform Provider"
  ip_netmask  = "10.10.10.2"
}

resource "sase_objects_address_groups" "test_terraform_01" {
  folder = "Shared"
  name   = "test-grp-01-terraform"
  static = [sase_objects_addresses.test_terraform_01.name, sase_objects_addresses.test_terraform_02.name]
}

resource "sase_objects_regions" "test_terraform_01" {
  folder = "Shared"
  name   = "test-region-01-terraform-london"
  geo_location = {
    latitude  = 51.5 # 51.500152
    longitude = 1    # -0.126236
  }
}

resource "sase_objects_services" "test_terraform_01_t22" {
  folder = "Shared"
  name   = "test-svc-01-terraform-t22"
  protocol = {
    tcp = {
      port = 22
    }
  }
}

resource "sase_objects_services" "test_terraform_01_u53" {
  folder = "Shared"
  name   = "test-svc-01-terraform-u53"
  protocol = {
    udp = {
      port = 53
    }
  }
}

resource "sase_objects_service_groups" "test_terraform_grp" {
  folder  = "Shared"
  name    = "test-svcgrp-01-terraform"
  members = [sase_objects_services.test_terraform_01_t22.name, sase_objects_services.test_terraform_01_u53.name]
}

resource "sase_objects_tags" "test_terraform_tag_01" {
  folder = "Shared"
  name   = "test-tag-01-terraform"
  color  = "Forest Green"
}

resource "sase_security_rules" "test_terraform_rule_01" {
  folder      = "Shared"
  position    = "post"
  name        = "Rule from Terraform"
  from        = ["trust"]
  source      = [sase_objects_address_groups.test_terraform_01.name]
  source_user = ["any"]
  to          = ["untrust"]
  destination = ["any"]
  application = ["ssh"]
  service     = [sase_objects_services.test_terraform_01_t22.name]
  category    = ["any"]
  action      = "allow"
  tag         = [sase_objects_tags.test_terraform_tag_01.name]
}
