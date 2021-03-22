#Declare AWS
provider "aws" {
  profile = "default"
  region  = "us-east-2"
}
#ADJUST

#Provision VPC
resource "aws_vpc" "alexlop_vpc" {
  cidr_block 	= "192.168.4.0/24"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "alexlop_vpc"
  }
}

#Provision Subnet
resource "aws_subnet" "alexlop_subnet" {
  availability_zone = "us-east-2a"
  vpc_id	= aws_vpc.alexlop_vpc.id
  cidr_block	= "192.168.4.0/26"
  tags = {
    Name = "alexlop_subnet"
  }
}
#ADJUST

#Provision Internet Gateway
resource "aws_internet_gateway" "alexlop_ig" {
  vpc_id	= aws_vpc.alexlop_vpc.id
  tags = {
    Name = "alexlop_ig"
  }
}

#Provision Route Table and Routes
#WARNING: Allows OPEN access to VPC
resource "aws_route_table" "alexlop_routetable" {
  vpc_id	= aws_vpc.alexlop_vpc.id
  route {
    cidr_block	= "0.0.0.0/0"
    gateway_id	= aws_internet_gateway.alexlop_ig.id
  }
  tags = {
    Name = "alexlop_routetable"
  }
}

#Associate Route Table to Subnet
resource "aws_route_table_association" "alexlop_associate" {
  subnet_id			= aws_subnet.alexlop_subnet.id
  route_table_id		= aws_route_table.alexlop_routetable.id
}

#Provision Security Group
#Allows HTTP access to EC2 Instance
#WARNING: Allows all outbound traffic
resource "aws_security_group" "alexlop_secgroup" {
  description 	= "alexlop example: provision vpc & ec2 using terraform"
  vpc_id	= aws_vpc.alexlop_vpc.id
  ingress {
    description = "HTTP into VPC"
    from_port	= 80
    to_port	= 80
    protocol 	= "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "alexlop_secgroup"
  }
}

#Provision EC2 Instance
#Image:AmazonLinux2AMI
resource "aws_instance" "alexlop_ec2" {
  ami				= "ami-08962a4068733a2b6"
  associate_public_ip_address 	= true
  instance_type			= "t2.micro"
  security_groups		= [aws_security_group.alexlop_secgroup.id]
  subnet_id			= aws_subnet.alexlop_subnet.id
  user_data			= <<-EOF
					#!/bin/bash
					sudo apt install nginx -y
					sudo systemctl start nginx
  				EOF
  tags				= {
    Name			= "alexlop_ec2"
  }
}
