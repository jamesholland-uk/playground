variable "location" {
  description = "Region to install VM Series Scale sets and dependencies."
}

variable "name_prefix" {
  description = "Prefix to add to all the object names here"
}

variable "vm_size" {
  description = "Azure VM size (type) to be created. Consult the *VM-Series Deployment Guide* as only a few selected sizes are supported."
  default     = "Standard_D3_v2"
  type        = string
}

variable "subnet_mgmt" {
  description = "Management subnet."
}

variable "subnet_public" {
  description = "External/public subnet"
}

variable "subnet_private" {
  description = "internal/private subnet"
}

variable "bootstrap_storage_account" {
  description = "Storage account setup for bootstrapping"
}

variable "bootstrap_share_name" {
  description = "File share for bootstrap config"
}

variable "username" {
  description = "Initial administrative username to use for VM-Series."
  default     = "panadmin"
  type        = string
}

variable "password" {
  description = "Initial administrative password to use for VM-Series."
  type        = string
}

variable "img_sku" {
  description = "VM-series SKU - list available with `az vm image list -o table --all --publisher paloaltonetworks`"
  default     = "bundle2"
  type        = string
}

variable "img_version" {
  description = "VM-series PAN-OS version - list available with `az vm image list -o table --all --publisher paloaltonetworks`"
  default     = "9.0.4"
  type        = string
}

variable "vm_count" {
  description = "Minimum instances per scale set."
  default     = 2
}

variable "vhd_container" {
  description = "Storage container for storing VMSS instance VHDs."
}

variable "lb_backend_pool_id" {
  description = "ID Of inbound load balancer backend pool to associate with the VM series firewall"
}

variable "accelerated_networking" {
  description = "If true, enable Azure accelerated networking (SR-IOV) for all dataplane network interfaces. [Requires](https://docs.paloaltonetworks.com/pan-os/9-0/pan-os-new-features/virtualization-features/support-for-azure-accelerated-networking-sriov) PAN-OS 9.0 or higher. The PAN-OS management interface (nic0) is never accelerated, whether this variable is true or false."
  default     = true
  type        = bool
}

#  ---   #
# Naming #
#  ---   #

# Seperator
variable "sep" {
  default = "-"
}

variable "name_rg" {
  default = "vmseries-rg"
}

variable "name_scale_set" {
  default = "inbound-scaleset"
}

variable "name_mgmt_nic_profile" {
  default = "inbound-nic-fw-mgmt-profile"
}

variable "name_mgmt_nic_ip" {
  default = "inbound-nic-fw-mgmt"
}

variable "name_fw_mgmt_pip" {
  default = "inbound-fw-mgmt-pip"
}

variable "name_domain_name_label" {
  default = "inbound-vm-mgmt"
}

variable "name_public_nic_profile" {
  default = "inbound-nic-fw-public-profile"
}

variable "name_public_nic_ip" {
  default = "inbound-nic-fw-public"
}

variable "name_private_nic_profile" {
  default = "inbound-nic-fw-private-profile"
}

variable "name_private_nic_ip" {
  default = "inbound-nic-fw-private"
}
variable "name_fw" {
  default = "inbound-fw"
}
