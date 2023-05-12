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

variable "ec2-name"{
  type = list(string)
  default = ["Dev", "Prod"]
}

resource "aws_instance" "app_server" {
  count = 2     # create 2 similar instances
  ami = "ami-0889a44b331db0194"
  instance_type = "t2.micro"
  tags = {
    Name = "Webserver",
    Env = element(var.ec2-name, count.index)
  }
}
