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
    vm1 = {
      name = "Dev-server"
      type = "t2.micro"
    }
    vm2 = {
      name = "Prod-server"
      type = "t2.small"
    }
  }

  ami           = "ami-0889a44b331db0194"
  instance_type = each.value.type
  tags = {
    Name = each.value.name
  }
}
