terraform {
  required_version = ">= 0.15.3, < 2.0"
  required_providers {
    random = { version = ">= 3.1.0" }
    null   = { version = ">= 3.1.0" }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  credentials = file("gcp.json")
}
