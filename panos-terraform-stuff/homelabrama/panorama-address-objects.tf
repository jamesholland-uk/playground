# resource "panos_panorama_address_object" "terraform-address-object-1" {
#     name = "terraform-address-object-pt1"
#     value = "192.168.80.1/32"
#     description = "Address object from Terraform"
#     device_group = "lab-vm-series"
#     lifecycle {
#         create_before_destroy = true
#         }
# }

# resource "panos_panorama_address_object" "terraform-address-object-2" {
#     name = "terraform-address-object-pt2"
#     value = "192.168.70.2/32"
#     description = "Address object from Terraform"
#     device_group = "lab-vm-series"
#     lifecycle {
#         create_before_destroy = true
#         }
# }

# resource "panos_panorama_address_object" "terraform-address-object-3" {
#     name = "terraform-address-object-pt3"
#     value = "192.168.70.3/32"
#     description = "Address object from Terraform"
#     device_group = "lab-vm-series"
#     lifecycle {
#         create_before_destroy = true
#         }
# }

# resource "panos_panorama_address_group" "terraform-address-group" {
#     name = "terraform-address-group"
#     static_addresses = [
#         panos_panorama_address_object.terraform-address-object-1.name,
#         panos_panorama_address_object.terraform-address-object-2.name
#     ]
#     device_group = "lab-vm-series"
#     lifecycle {
#         create_before_destroy = true
#         }
# }
