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

data "aws_ami" "example"{
  filter {
    name = "name"
    values = [
      #this is AMI name for ARM architecture based AMI
      #"al2023-ami-2023.0.20230503.0-kernel-6.1-arm64",
      
      #this is AMI name for x86_64 architecture based AMI
      "al2023-ami-2023.0.20230503.0-kernel-6.1-x86_64"
    ]
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-0889a44b331db0194" #Amazon Linux X86_64
  instance_type = "t2.micro"
  tags = {
    Name = "Webserver"
    Person = "John",
    Dept = "Sales"
  }

  lifecycle {
    ignore_changes = [
      tags
      ]

    prevent_destroy = false

    precondition {
      condition = data.aws_ami.example.architecture == "x86_64"
      error_message = "The selected AMI must be for the x86_64 architecture"
    }

    postcondition {
      condition = self.tags["Name"] == "Webserver" # self implies current resource
      error_message = "Tag Name must be Webserver"
    } 
  }
}
