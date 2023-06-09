variable "ami_id" {
  type    = string
  default = "ami-0889a44b331db0194"
}

variable "app_name" {
  type    = string
  default = "httpd"
}

locals {
    app_name = "httpd"
}

source "amazon-ebs" "httpd" {
  access_key = ""
  secret_key = ""
  ami_name      = "PACKER-DEMO-${local.app_name}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami    = "${var.ami_id}"
  ssh_username  = "ec2-user"
  tags = {
    Env  = "DEMO"
    Name = "PACKER-DEMO-${var.app_name}"
  }
}

build {
  sources = ["source.amazon-ebs.httpd"]
  provisioner "shell" {
    script = "script.sh"
  }
  post-processor "shell-local" {
    inline = ["echo foo"]
  }
}
