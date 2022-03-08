# resource "panos_panorama_tunnel_interface" "gcp_tunnel" {
#   template = "lab-vm-series"
#   name = "tunnel.8"
#   comment = "Tunnel for GCP demo"

#   lifecycle {
#       create_before_destroy = true
#   }
# }

# data "panos_system_info" "device_info" { }

# output "model" {
#     value = data.panos_system_info.device_info.info.model
# }
