terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"

  backend "s3" {
    bucket = "demobucket2060"
    key = "webserver/terraform_state"
    region = "us-east-1"
  }
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
