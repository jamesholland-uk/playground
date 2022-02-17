# resource "panos_custom_url_category" "tf-cat" {
#     name = "tf-cat"
#     description = "Made by Terraform"
#     sites = [
#         "foo.org",
#         "bar.com",
#         "example.com",
#     ]
#     type = data.panos_system_info.x.version_major >= 9 ? "URL List" : ""
#     device_group = "lab-vm-series"
# }

# data "panos_system_info" "x" {}