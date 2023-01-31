# Cloud NGFW Overall Status
output "cloudngfw_status" {
  value = cloudngfwaws_ngfw.the_cloud_ngfw.status[0]
}
