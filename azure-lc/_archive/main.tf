module "panorama" {
  source  = "PaloAltoNetworks/vmseries-modules/azurerm//modules/panorama"
  version = "0.2.0"

  panorama_name       = var.panorama_name
  resource_group_name = var.resource_group_name
  location            = var.location
  avzone              = var.avzone
  enable_zones        = var.enable_zones
  custom_image_id     = var.custom_image_id
  panorama_sku        = var.panorama_sku
  panorama_size       = var.panorama_size
  panorama_version    = var.panorama_version
  tags                = var.tags

  interface = [ // Only one interface in Panorama VM is supported
    {
      name               = "mgmt"
      subnet_id          = var.subnet_names[0]
      private_ip_address = var.panorama_private_ip_address
      public_ip          = true
      public_ip_name     = var.panorama_name
    }
  ]

  logging_disks = {
    disk_name_1 = {
      size : "2048"
      lun : "1"
    }
    disk_name_2 = {
      size : "2048"
      lun : "2"
    }
  }

  username                    = var.username
  password                    = var.password
  boot_diagnostic_storage_uri = var.boot_diagnostic_storage_uri
}
