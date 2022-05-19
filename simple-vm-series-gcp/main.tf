

# Create VPC the VM-Series to live within
module "vpc" {
  source = "github.com/PaloAltoNetworks/terraform-google-vmseries-modules/modules/vpc"

  networks = [
    {
      name            = "${var.name_prefix}fw-mgmt"
      subnetwork_name = "${var.name_prefix}fw-mgmt"
      ip_cidr_range   = var.mgmt_cidr_range
      allowed_sources = var.allowed_sources
    },
    {
      name            = "${var.name_prefix}fw-outside"
      subnetwork_name = "${var.name_prefix}fw-outside"
      ip_cidr_range   = var.outside_cidr_range
      allowed_sources = var.allowed_sources
    },
    {
      name            = "${var.name_prefix}fw-inside"
      subnetwork_name = "${var.name_prefix}fw-inside"
      ip_cidr_range   = var.inside_cidr_range
    },
  ]
}



# Create the VM-Series
module "vmseries" {
  for_each = var.vmseries
  source   = "github.com/PaloAltoNetworks/terraform-google-vmseries-modules/modules/vmseries"

  name = "${var.name_prefix}${each.key}"
  zone = each.value.zone

  ssh_keys       = var.ssh_keys
  vmseries_image = var.vmseries_common.vmseries_image

  create_instance_group = true

  bootstrap_options = var.bootstrap_data

  network_interfaces = [
    {
      subnetwork       = module.vpc.subnetworks["${var.name_prefix}fw-mgmt"].self_link
      private_address  = each.value.private_ips["mgmt"]
      create_public_ip = true
    },
    {
      subnetwork      = module.vpc.subnetworks["${var.name_prefix}fw-outside"].self_link
      private_address = each.value.private_ips["outside"]
    },
    {
      subnetwork      = module.vpc.subnetworks["${var.name_prefix}fw-inside"].self_link
      private_address = each.value.private_ips["inside"]
    },
  ]
}
