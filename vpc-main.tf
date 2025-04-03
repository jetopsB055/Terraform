resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true  
  tags = {
    Name = "demo-vpc"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_1_cidr_block
  availability_zone = var.subnet_1_az
}

resource "aws_subnet" "subnet_2" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_2_cidr_block
  availability_zone = var.subnet_2_az
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
}
