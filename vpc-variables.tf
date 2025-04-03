variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_1_cidr_block" {
  description = "The CIDR block for subnet 1"
  type        = string
}

variable "subnet_1_az" {
  description = "The availability zone for subnet 1"
  type        = string
}

variable "subnet_2_cidr_block" {
  description = "The CIDR block for subnet 2"
  type        = string
}

variable "subnet_2_az" {
  description = "The availability zone for subnet 2"
  type        = string
}
