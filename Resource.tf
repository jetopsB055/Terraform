resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.1.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "TF_VPC"
  }
}

resource "aws_subnet" "my_subnet1" {
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = "us-east-2a"
  cidr_block        = "10.1.1.0/24"
  depends_on        = [aws_vpc.my_vpc]
  tags = {
    Name = "TF_Subnet1"
  }
}

resource "aws_subnet" "my_subnet2" {
  vpc_id            = aws_vpc.my_vpc.id
  availability_zone = "us-east-2b"
  cidr_block        = "10.1.2.0/24"
  depends_on        = [aws_subnet.my_subnet1]
  tags = {
    Name = "TF_Subnet2"
  }
}

resource "aws_instance" "New_EC2" {
  count                       = var.instance_count
  ami                         = data.aws_ami.windows.id
  instance_type               = "t2.micro"
  availability_zone           = var.availability_zone_names
  subnet_id                   = aws_subnet.my_subnet2.id
  key_name                    = "win-1"
  associate_public_ip_address = true

  tags = {
    Name = "TF-windows-${count.index + 1}"
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }
}

resource "aws_s3_bucket" "s3_bucket" {
  count  = var.bucket_count
  bucket = "worldtrain-${count.index + 1}"
  # acl    = "public-read-write"

  tags = {
    Name = "worldtrain-${count.index + 1}"
  }
}

# resource "aws_instance" "New_EC2" {
#   ami                         = data.aws_ami.windows.id
#   instance_type               = "t2.micro"
#   availability_zone           = var.availability_zone_names
#   subnet_id                   = aws_subnet.my_subnet2.id
#   key_name                    = "win-1"
#   associate_public_ip_address = true

#   tags = {
#     Name = "TF-windows"
#   }
#   root_block_device {
#     volume_type = "gp2"
#     volume_size = 30
#   }
# }

# resource "aws_s3_bucket" "s3_bucket" {  
#   bucket = "worldtrain"
#   acl    = "public-read-write"

#   tags = {
#     Name = "worldtrain"
#   }
# }

# module "http_80_security_group" {
#   source  = "./modules/http-80"
#   name    = var.security_group_id
#   vpc_id  = aws_vpc.my_vpc.id
# }
