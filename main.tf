terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"  # Update to your preferred region
}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Demo-VPC"
  }
}

# Create a subnet within the VPC
resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Demo-subnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "my_gateway" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "demo-internet-gateway"
  }
}

# Create a Route Table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  # Define routes for the route table
  route {
    cidr_block = "0.0.0.0/0"  # This allows outbound internet traffic
    gateway_id = aws_internet_gateway.my_gateway.id
  }

  tags = {
       Name = "demo-route-table"  # Name = "demo-public-route-table"
  }  
}
# Associate the Route Table with the Subnet
resource "aws_route_table_association" "my_route_table_association" {
subnet_id      = aws_subnet.my_subnet.id
route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table" "my_route_table1" {
  vpc_id = aws_vpc.my_vpc.id

  # Define routes for the route table
  route {
    cidr_block = "10.0.0.0/16"
  }

  tags = {
       Name = "demo-private-route-table"  # Name = "demo-public-route-table"
  }  
}

# Create a Security Group
resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.my_vpc.id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  tags = {
    Name = "demo-security-group"
  }
}

# Launch an EC2 instance
resource "aws_instance" "my_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Use a valid Amazon Linux 2 AMI ID in your region ami-002f6e91abff6eb96 ami-0c55b159cbfafe1f0
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  key_name      = "windows" # "linux-servr"
  associate_public_ip_address = true

  tags = {
    Name = "demo-instance"
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 8
  }
}

resource "aws_s3_bucket" "my_free_tier_bucket" {
  bucket = "kanchi09232024"  # S3 bucket name must be globally unique my-free-tier-bucket-example
  # region = "us-east-1"
  # acl    = "private"

  tags = {
    Name = "kanchi09232024"
    Environment = "Dev"
  } 
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.my_free_tier_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

