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
    for_each = toset(["dev-", "prod-"])
    source = "./storage"
    bucket_name = "${each.value}demobucketsc"
}

output "my_bucket_domain_name" {
  value = [
    for bucket in module.create_s3_bucket : bucket.my_bucket_domain_name
  ]
}