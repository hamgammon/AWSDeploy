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

data "aws_ami" "amzn_linux_2023" {
  filter {
    name = "name"
    values = [
      #this is AMI name for x86_64 architecture based AMI
      "al2023-ami-2023.0.20230503.0-kernel-6.1-x86_64"
    ]
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.amzn_linux_2023.id
  instance_type = "t2.micro"
  tags = {
    Name = "WebServer"
  }
}
