provider "aws" {
  region = "ap-south-1" # Change to your AWS region
}


resource "aws_key_pair" "self_healing_key" {
  key_name   = "self-healing-key"
  public_key = file("~/.ssh/id_rsa.pub") # Path to your public key
}


resource "aws_security_group" "self_healing_sg" {
  name        = "self-healing-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
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

data "aws_vpc" "default" {
  default = true
}


resource "aws_instance" "self_healing_ec2" {
  ami           = "ami-0dee22c13ea7a9a67" # Amazon Linux 2 AMI (ap-south-1, change if needed)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.self_healing_key.key_name
  security_groups = [aws_security_group.self_healing_sg.name]

  tags = {
    Name = "Self-Healing-EC2"
  }
}


output "ec2_public_ip" {
  value = aws_instance.self_healing_ec2.public_ip
}
