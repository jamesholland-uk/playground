# resource "panos_panorama_address_object" "terraform-address-object-1" {
#     name = "terraform-address-object-1"
#     value = "192.168.80.1/32"
#     description = "Addres object from Terraform"
# }

# resource "panos_panorama_address_object" "terraform-address-object-2" {
#     name = "terraform-address-object-pt2"
#     value = "192.168.70.2/32"
#     description = "Addres object from Terraform"
# }

# resource "panos_panorama_address_group" "terraform-address-group" {
#     name = "terraform-address-group"
#     static_addresses = [
#         panos_panorama_address_object.terraform-address-object-1.name,
#         panos_panorama_address_object.terraform-address-object-2.name
#     ]
# }

# resource "panos_panorama_address_object" "terraform-address-object-1" {
#     name = "terraform-address-object-1"
#     value = "192.168.80.1/32"
#     description = "Addres object from Terraform"
#     lifecycle {
#         create_before_destroy = true
#         }
# }

# resource "panos_panorama_address_object" "terraform-address-object-2" {
#     name = "terraform-address-object-pt2"
#     value = "192.168.80.2/32"
#     description = "Addres object from Terraform"
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
#     lifecycle {
#         create_before_destroy = true
#         }
# }