#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo echo "<h1>Welcome to Scott's Amazon Linux Image, this has been an AMI image I made. <br> My name is $(hostname -f)</h1>" > /var/www/html/index.html