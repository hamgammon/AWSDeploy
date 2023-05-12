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
  # access_key = ""
  # secret_key = ""
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0889a44b331db0194"
  instance_type = "t2.small"
  tags = {
    Name = "WebServer",
    Env = "Dev"
  }
}

output "app_server_public_ip" {
  value = aws_instance.app_server.public_ip
}
