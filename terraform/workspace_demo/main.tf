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

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "env" {
  type = string
  default = "dev"
}
resource "aws_instance" "app_server" {
  count = "${terraform.workspace == "prod" ? 2 : 1}"
  ami           = "ami-0889a44b331db0194"
  instance_type = var.instance_type
  tags = {
    Name = format("webserver-%s-%s",var.env, count.index+1)
  }
}

