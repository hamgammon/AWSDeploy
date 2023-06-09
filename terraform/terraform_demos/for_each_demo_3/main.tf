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

resource "aws_instance" "app_server" {
  for_each = {
    Dev-Server = "ami-0889a44b331db0194"
    Prod-Server = "ami-007855ac798b5175e"
  }

  ami           = each.value
  instance_type = "t2.micro"
  tags = {
    Name = each.key
  }
}
