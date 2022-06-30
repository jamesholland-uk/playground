variable "location" {
  description = "The Azure region to use."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group to create."
  type        = string
}

variable "username" {
  description = "Initial administrative username. Mind the [Azure-imposed restrictions](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/faq#what-are-the-username-requirements-when-creating-a-vm)."
  type        = string
}

variable "allow_inbound_mgmt_ips" {
  description = <<-EOF
    List of IP CIDR ranges (like `["23.23.23.23"]`) that are allowed to access management interfaces of VM-Series.
    If you use Panorama, include its address in the list (as well as the secondary Panorama's).
  EOF
  type        = list(string)
}

variable "common_vmseries_sku" {
  description = "VM-Series SKU, for example `bundle1`, or `bundle2`. If it is `byol`, the VM-Series starts unlicensed."
  type        = string
}

variable "common_vmseries_version" {
  description = "VM-Series PAN-OS version"
  type        = string
}

variable "storage_account_name" {
  description = <<-EOF
  Default name of the storage account to create for bootstrap.
  The name you choose must be unique across Azure. The name also must be between 3 and 24 characters in length, and may include only numbers and lowercase letters.
  EOF
  default     = "pantfstorage"
  type        = string
}

variable "files" {
  description = "Map of all files to copy to bootstrap bucket. The keys are local paths, the values are remote paths. Always use slash `/` as directory separator (unix-like), not the backslash `\\`. For example `{\"dir/my.txt\" = \"config/init-cfg.txt\"}`"
  default     = {}
  type        = map(string)
}

variable "network_security_groups" {
  description = "Definition of Network Security Groups to create. Refer to the `vnet` module documentation for more information."
}
