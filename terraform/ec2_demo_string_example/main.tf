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
  region  = "us-east-1"
}

variable "ec2-name" {
  type = list(string)
  default = ["web-1","web-2"]   
}

resource "aws_instance" "app_server" {
  count = 2
  ami           = "ami-0889a44b331db0194"
  instance_type = "t2.micro"
  tags = {
    Name = format("Server-%s", element(var.ec2-name, count.index))
  }
}

