terraform {
    required_providers {
        panos = {
            source  = "paloaltonetworks/panos"
            version = "~> 1.10.0"
        }
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "panos" {
    hostname = var.panos_hostname
    username = var.panos_username
    password = var.panos_password
}

provider "aws" {
    region     = var.aws_region
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
}