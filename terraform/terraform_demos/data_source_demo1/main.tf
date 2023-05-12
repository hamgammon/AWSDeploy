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

data "aws_security_group" "webserver_sg" {
    id = "sg-01ed2393e17d2dc0c"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0889a44b331db0194"
  instance_type = "t2.micro"
  security_groups = [data.aws_security_group.webserver_sg.name]
  tags = {
    Name = "WebServer"
  }
}
