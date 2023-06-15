output "instance_ips" {
  value = aws_instance.New_EC2[*].public_ip
}

output "S3_Bucket_names" {
  value = aws_s3_bucket.s3_bucket[*].bucket
}

# output "instance_ips" {
#   value = aws_instance.New_EC2.public_ip
# }

# output "S3_Bucket_names" {
#   value = aws_s3_bucket.s3_bucket.bucket
# }

# output "module_security_group_id" {
#   value = module.security_group.security_group_id
# }
