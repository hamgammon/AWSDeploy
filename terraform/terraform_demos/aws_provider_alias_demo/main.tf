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

provider "aws" {
  alias = "west"
  region = "us-west-2"
}

resource "aws_instance" "app_server_1" {
  ami = "ami-0889a44b331db0194"
  instance_type = "t2.micro"
  tags = {
    Name = "WebServer-east"
  }
}

resource "aws_instance" "app_server_2" {
  provider = aws.west
  ami = "ami-04e914639d0cca79a"
  instance_type = "t2.micro"
  tags = {
    Name = "WebServer-west"
  }
}