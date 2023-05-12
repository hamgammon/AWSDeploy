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

resource "aws_instance" "app_server" {
  ami           = "ami-0889a44b331db0194"
  instance_type = "t2.small"
  security_groups = [ "Webserver-SG" ]
  key_name = "ec2-key"
  tags = {
    Name = "WebServer"
  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ip.txt"
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> public_ip.txt"
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("ec2-key.pem")
    host = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [ 
        "#!/bin/bash",
        "sudo yum update -y",
        "sudo yum install httpd -y",
        "sudo systemctl start httpd",
        "sudo systemctl enable httpd"
     ]
  }

  provisioner "file" {
    source = "./index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [ 
      "sudo mv /tmp/index.html /var/www/html/index.html"
     ]
  }
}

output "instance_private_ip" {
    value = aws_instance.app_server.private_ip
}

output "instance_public_ip" {
    value = aws_instance.app_server.public_ip
}
