  terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.39"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
  }
  required_version = "~> 1.2"
}

provider "aws" {
  region = "us-east-1"
}

# Create (and display) an SSH key
resource "tls_private_key" "mykey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save SSH private key in local file
resource "local_file" "private_key" {
  content         = tls_private_key.mykey.private_key_pem
  filename        = "aws.pem"
  file_permission = "0400"
}

# registered public key with AWS
resource "aws_key_pair" "public_key" {
  key_name   = "ec2_key"
  public_key = tls_private_key.mykey.public_key_openssh
}

# Create virtual network (VPC)
resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my_custom_vpc"
  }
}

# Create subnet and make it public through (see Route table resource below)
resource "aws_subnet" "subnet_public" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "my_public_subnet"
  }
}

# Create Internet Gateway to enables communication between VPC and internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}

# Create Route table to direct traffic 
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associate Route table with Subnet (Subnet becomes public since route table has route to Internet)
resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rtb_public.id
}

# Create Security Group and rules
resource "aws_security_group" "webserver_sg" {
  name   = "webserver_sg"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Elastic network interface (ENI)
resource "aws_network_interface" "primary_eni" {
  subnet_id       = aws_subnet.subnet_public.id
}

# Attach security group to an Elastic Network Interface (ENI)
resource "aws_network_interface_sg_attachment" "sg_attachment" {
  security_group_id    = aws_security_group.webserver_sg.id
  network_interface_id = aws_network_interface.primary_eni.id
}

# Create public IP (Elastic IP)
resource "aws_eip" "ec2_ipaddress" {
  network_interface = aws_network_interface.primary_eni.id
  depends_on        = [aws_internet_gateway.igw, aws_instance.web]
}

# Create EC2 instance (virtual machine)
resource "aws_instance" "web" {
  ami                         = "ami-0889a44b331db0194"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.public_key.key_name
  network_interface {
    network_interface_id = aws_network_interface.primary_eni.id
    device_index         = 0
  }
  tags = {
    Name = "Webserver"
  }
}
