variable "availability_zone_names" {
  type    = string
  default = "us-east-2b"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}

variable "bucket_count" {
  description = "Number of S3 buckets to create"
  type        = number
  default     = 2
}

variable "security_group_id" {
  description = "ID of existing security group whose rules we will manage"
  type        = string
  default     = "sg-new"
}