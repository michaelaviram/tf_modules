terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "ec2" {
  count                  = length(var.name)
  ami                    = var.ami
  instance_type          = var.type
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = var.key

  tags = {
    Name = element(var.name[*], count.index)
  }
}

resource "aws_ec2_instance_state" "state" {
  count       = length(var.name)
  instance_id = element(aws_instance.ec2[*].id, count.index)
  state       = var.state
}


resource "aws_security_group" "sg" {
  name        = "security group"
  description = "Security group for ec2 isntance"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = var.protocol
    cidr_blocks = var.my_ip
  }

  dynamic "ingress" {
    for_each = var.port
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.protocol
      cidr_blocks = var.cidr_blocks
      description = "Allow all inbound traffic on port ${ingress.value}"
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


