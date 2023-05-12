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

data "aws_instance" "instance" {
  filter {
    name = "tag:Env" 
    values = ["Prod"]
  }
}

output "ec2_public_ip" {
  value = data.aws_instance.instance.public_ip
}
