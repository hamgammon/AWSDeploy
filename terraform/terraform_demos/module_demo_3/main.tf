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
  for_each = toset(["dev","prod"])
  source = "s3::https://demobucket2060.s3-us-east-1.amazonaws.com/s3create.zip"
  bucket_name = "${each.value}-demobucket2060"
}

output "my_bucket_domain_name" {
  value = [
    for bucket in module.create_s3_bucket : bucket.abc    
  ]
}