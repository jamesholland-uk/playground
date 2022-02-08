# Resource group to hold all the resources.
resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

# Generate a random password for VM-Series.
resource "random_password" "this" {
  length           = 16
  min_lower        = 16 - 4
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  override_special = "_%@"
}

# Virtual Network and its Network Security Group
module "vnet" {
  source  = "PaloAltoNetworks/vmseries-modules/azurerm//modules/vnet"
  version = "0.2.0"

  virtual_network_name = "vnet-vmseries"
  location             = var.location
  resource_group_name  = azurerm_resource_group.this.name
  address_space        = ["10.110.0.0/16"]
  network_security_groups = var.network_security_groups
  route_tables = {}
  subnets = {
    "subnet-mgmt" = {
      address_prefixes       = ["10.110.255.0/24"]
      network_security_group = "sg-mgmt"
    }
    "subnet-private" = {
      address_prefixes       = ["10.110.0.0/24"]
      network_security_group = "sg-private"
    }
    "subnet-public" = {
      address_prefixes       = ["10.110.129.0/24"]
      network_security_group = "sg-public"
    }
  }
}

# The VM-Series bootstrap
module "bootstrap" {
  source  = "PaloAltoNetworks/vmseries-modules/azurerm//modules/bootstrap"
  version = "0.2.0"

  resource_group_name  = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location
  storage_account_name = var.storage_account_name
  files                = var.files
}

# The VM-Series virtual machine
module "vmseries" {
  source  = "PaloAltoNetworks/vmseries-modules/azurerm//modules/vmseries"
  version = "0.2.0"

  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  name                = "myfw"
  username            = var.username
  password            = random_password.this.result
  img_sku             = var.common_vmseries_sku
  img_version         = var.common_vmseries_version
  interfaces = [
    {
      name             = "myfw-mgmt"
      subnet_id        = lookup(module.vnet.subnet_ids, "subnet-mgmt", null)
      create_public_ip = true
    },
    {
      name                = "public-interface"
      subnet_id           = lookup(module.vnet.subnet_ids, "subnet-public", null)
      create_public_ip    = true
      enable_backend_pool = false
    },
    {
      name                = "inside-interface"
      subnet_id           = lookup(module.vnet.subnet_ids, "subnet-private", null)
      enable_backend_pool = false
    },
  ]
  bootstrap_storage_account     = module.bootstrap.storage_account
  bootstrap_share_name          = module.bootstrap.storage_share.name
}
