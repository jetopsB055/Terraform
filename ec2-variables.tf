variable "ami_id" {
  description = "The AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance"
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance into"
  type        = string
}

variable "key_name" {
  description = "The key pair name to use"
  type        = string
}
