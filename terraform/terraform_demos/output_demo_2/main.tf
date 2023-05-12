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
  count = 2
  ami           = "ami-0889a44b331db0194"
  instance_type = "t2.small"
  tags = {
    Name = "WebServer",
    Env = "Dev"
  }
}

#output variable is a list
output "app_server_public_ip" {
  value = [ 
    for instance in aws_instance.app_server: instance.public_ip
   ]
}

output "app_server_public_ip_0" {
  value = aws_instance.app_server[0].public_ip
}

output "app_server_public_ip_1" {
  value = aws_instance.app_server[1].public_ip
}
