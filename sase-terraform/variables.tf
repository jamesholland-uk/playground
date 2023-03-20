variable "sase_client_id" {
  type        = string
  description = "Client ID for Cloud Managed SASE/Prisma Access"
}

variable "sase_client_secret" {
  type        = string
  description = "Client Secret for Cloud Managed SASE/Prisma Access"
}

variable "sase_scope" {
  type        = string
  description = "Scope for Cloud Managed SASE/Prisma Access (usually tsg:<TSG>)"
}
