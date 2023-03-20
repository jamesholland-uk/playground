terraform {
  required_providers {
    sase = {
      source  = "paloaltonetworks-local/sase"
      version = "1.0.0"
    }
  }
}

provider "sase" {
  client_id     = var.sase_client_id
  client_secret = var.sase_client_secret
  scope         = var.sase_scope
}
