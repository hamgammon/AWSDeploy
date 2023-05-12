terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

module "create_s3_bucket" {
  source = "./storage"
  bucket_name = "demobucket-2060"
}

output "my_bucket_domain_name" {
  value = module.create_s3_bucket.abc
}