terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

// ******************************************************************************************

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "admin_user_arn" {
  type = string
  // This is the admin user who will perform the Cloud NGFW operations,configuration,etc
  // example: "arn:aws:iam::1234567890:user/my-username"
}

// ******************************************************************************************

resource "aws_iam_role" "ngfw_role" {
  name = "CloudNGFWRole"

  inline_policy {
    name = "apigateway_policy"

    // A policy that allowed access to AWS API...
    policy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "execute-api:Invoke",
            "execute-api:ManageConnections"
          ],
          "Resource" : "arn:aws:execute-api:*:*:*"
        }
      ]
    })
  }

  // ...and the policy above can be assumed, via this role, by the admin user account
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "apigateway.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      },
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            var.admin_user_arn
          ]
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    CloudNGFWRulestackAdmin = "Yes"
    CloudNGFWFirewallAdmin  = "Yes"
    # CloudNGFWGlobalRulestackAdmin = "Yes"
  }
}

// ******************************************************************************************

output "role_arn" {
  value = aws_iam_role.ngfw_role.arn
}
