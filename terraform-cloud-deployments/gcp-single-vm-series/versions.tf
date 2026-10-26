terraform {
  required_version = "1.17.0"
  required_providers {
    random = { version = "3.9.1" }
    null   = { version = "3.3.2" }
  }
}

provider "google" {
  project     = var.project
  region      = var.region
  credentials = file("gcp.json")
}
