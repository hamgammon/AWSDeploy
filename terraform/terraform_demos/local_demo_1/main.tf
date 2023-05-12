terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

locals {
  greeting = "Good evening!"
  sum = 10 + 20
}

output "greeting" {
  value = local.greeting
}

output "result_of_add" {
  value = local.sum
}
