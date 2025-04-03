provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr_block       = "10.0.0.0/16"
  subnet_1_cidr_block = "10.0.1.0/24"
  subnet_1_az         = "ap-south-1b"
  subnet_2_cidr_block = "10.0.2.0/24"
  subnet_2_az         = "ap-south-1b"  
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source       = "./modules/ec2"
  ami_id       = "ami-002f6e91abff6eb96" # Update with a valid AMI ID
  instance_type = "t2.micro"
  subnet_id    = module.vpc.subnet_ids[0]
  key_name     = "windows" # Replace with your key name
}

output "instance_id" {
  value = module.ec2.instance_id
}

output "security_group_id" {
  value = module.security_group.security_group_id
}
