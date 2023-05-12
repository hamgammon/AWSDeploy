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

locals {
  common_tags = {
    Name = "Webserver",
    Env = "Prod"
  }
}

variable "ami_ids" {
  type = list(string)
    default = [ "ami-0889a44b331db0194","ami-007855ac798b5175e" ]
}

resource "aws_instance" "app_server" {
  for_each = toset(var.ami_ids)  
  ami           = each.value
  instance_type = "t2.small"
  tags = merge(local.common_tags, {"Dept" = "Sales"})
}

output "app_server_public_ip" {
  value = [ 
    for instance in aws_instance.app_server: instance.public_ip
   ]
}