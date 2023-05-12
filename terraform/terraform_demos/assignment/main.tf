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
  
  backend "s3" {
    bucket = "demobucket2050"
    key    = "tmac-webserver/terraform_state"
    region = "us-east-2"
  }
}

provider "aws" {
  region = "us-west-2"
}

# Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save SSH private key in local file
resource "local_file" "private_key" {
  content         = tls_private_key.example_ssh.private_key_pem
  filename        = "aws.pem"
  file_permission = "0600"
}

# key pair's public key will be registered with AWS
resource "aws_key_pair" "generated_key" {
  key_name   = "tmac_key"
  public_key = tls_private_key.example_ssh.public_key_openssh
}

# Create virtual network (VPC)
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    "Name" = "tmac_VPC"
  }
}

# Create subnet for frontend access
resource "aws_subnet" "frontend_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
}

# Create subnet for frontend access
resource "aws_subnet" "backend_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2a"
}

resource "aws_subnet" "backend_subnet2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2b"
}


# Create Internet Gateway to enables communication between VPC and internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

# Create Route table to direct traffic 
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Associate Route table with Subnet (Subnet becomes public since route table has route to Internet)
resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.frontend_subnet.id
  route_table_id = aws_route_table.rtb_public.id
}

# Create Security Group and rules
resource "aws_security_group" "webserver_sg" {
  name   = "tmac_webserver_sg"
  vpc_id = aws_vpc.vpc.id
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

# Create Security Group and rules
resource "aws_security_group" "db_sg" {
  name   = "tmac_db_sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.webserver_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami           = "ami-06e85d4c3149db26a"
  count = 2
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  instance_type = "t2.micro"
  key_name = aws_key_pair.generated_key.key_name
  #user_data = templatefile("user_data.tftpl",{})
  subnet_id = aws_subnet.frontend_subnet.id
  tags = {
    Name = "tmac-Webserver",
  }

  provisioner "local-exec" {
      command = "echo The server's IP address is ${self.private_ip} > private_ip.txt"
    }

  provisioner "local-exec" {
      command = "echo The server's IP address is ${self.public_ip} > public_ip.txt"
    }
}

output "app_server1_private_ip" {
  value = aws_instance.app_server[0].private_ip
}

output "app_server1_public_ip" {
  value = aws_instance.app_server[0].public_ip
}

output "app_server2_private_ip" {
  value = aws_instance.app_server[1].private_ip
}

output "app_server2_public_ip" {
  value = aws_instance.app_server[1].public_ip
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.backend_subnet.id, aws_subnet.backend_subnet2.id]
  tags = {
    Name = "My DB subnet group"
  }
}



resource "aws_db_instance" "mysql" {
    allocated_storage = 20
    identifier = "tmac-mysql-db-instance"
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "5.7.41"
    instance_class = "db.t3.micro"
    username = "admin"
    password = "mysql1234"
    publicly_accessible = true
    skip_final_snapshot = true
    vpc_security_group_ids = [aws_security_group.db_sg.id]
    db_subnet_group_name = aws_db_subnet_group.default.name
    multi_az = false
}

/*
resource "aws_lb_target_group" "front-end-server" {
  name     = "application-front-end"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 3
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "attach-server" {
  count  = 2
	target_group_arn = aws_lb_target_group.front-end-server.arn
  target_id        = aws_instance.app_server[count.index].id
  port             = 80
}

resource "aws_lb" "front-end" {
  name               = "front"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.webserver_sg.id]
  subnets            = [aws_subnet.frontend_subnet.id]
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front-end.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front-end-server.arn
  }

}
*/