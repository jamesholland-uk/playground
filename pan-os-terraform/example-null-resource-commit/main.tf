provider "panos" {}

module "networking" {
  source = "./modules/networking"

  template = var.template
  stack    = var.stack
}

module "policies" {
  source = "./modules/policies"

  device_group = var.device_group

  zone_untrust = module.networking.zone_untrust
  zone_web     = module.networking.zone_web
  zone_db      = module.networking.zone_db

  interface_untrust = module.networking.interface_untrust
  interface_web     = module.networking.interface_web
  interface_db      = module.networking.interface_db
}

resource "null_resource" "commit_panorama" {
  provisioner "local-exec" {
    # This command is executed to perform a commit
    # This could be a single binary, a script, a curl to the PAN-OS API, or whatever is preferred
    # For Panorama, this could be a commit only, or a commit and push
    # This example assumes a local Golang binary is present, which will reuse environment variables used by the PAN-OS provider
    command = "./commit"
  }

  depends_on = [
    # These explicitly defined dependencies ensure the commit is performed only once the resources above are configured successfully
    module.policies.security_rule_group,
    module.policies.nat_rule_group
  ]
}
