# Define provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.5"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC (with default Security Group)
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.example.id
}

# Create subnets
resource "aws_subnet" "dmz1" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "DMZ1"
  }
}

resource "aws_subnet" "dmz2" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "DMZ2"
  }
}

output "vpc_id" {
  value = aws_vpc.example.id
}

output "dmz1_subnet_id" {
  value = aws_subnet.dmz1.id
}
output "dmz2_subnet_id" {
  value = aws_subnet.dmz2.id
}
