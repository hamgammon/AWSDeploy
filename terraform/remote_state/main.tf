terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
  
  backend "s3" {
    bucket = "mys3terraformsc"
    key = "webserver/terraform_state_sc"
    region = "us-east-1"
  }
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0889a44b331db0194"
  instance_type = "t2.micro"
  tags = {
    Name = "My-WebServer"
  }
}

