output "panorama_url" {
  description = "Panorama instance URL."
  value       = "https://${module.panorama.mgmt_ip_address}"
}

output "username" {
  description = "Panorama administrator's initial username."
  value       = var.username
}

output "panorama_admin_password" {
  description = "Panorama administrator's initial password."
  value       = var.password
  sensitive   = true
}
