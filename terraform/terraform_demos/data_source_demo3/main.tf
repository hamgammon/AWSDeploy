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

data "aws_key_pair" "ec2_key" {
  key_name = "webserverKey"  
}

resource "aws_instance" "app_server" {
  ami             = "ami-0889a44b331db0194"
  instance_type   = "t2.micro"
  security_groups = [data.aws_security_group.webserver_sg.name]
  key_name = data.aws_key_pair.ec2_key.key_name
  tags = {
    Name = "WebServer"
  }
}
