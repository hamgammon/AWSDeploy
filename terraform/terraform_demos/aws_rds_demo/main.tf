terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.39"
    }
  }
  required_version = "~> 1.2"
}

provider "aws" {
  region = "us-east-1"
  #access_key = ""
  #secret_key = ""
}

data "aws_vpc" "vpc"{
    id = "vpc-204b3d49"
}

resource "aws_security_group" "mysql_sg" {
  name   = "mysql_sg"
  vpc_id = data.aws_vpc.vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #security_groups = [id of the EC2 security_group]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "mysql" {
    allocated_storage = 20
    identifier = "mysql-db-instance"
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "5.7.41"
    instance_class = "db.t3.micro"
    username = "admin"
    password = "mysql1234"
    publicly_accessible = true
    skip_final_snapshot = true
    vpc_security_group_ids = [aws_security_group.mysql_sg.id]
}