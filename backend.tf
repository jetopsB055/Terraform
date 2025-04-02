terraform {
  backend "s3" {
    bucket         = "kanchi09232024"  # Replace with your S3 bucket name
    key            = "test-terraform.tfstate"    # Path within the bucket to store the state file
    region         = "ap-south-1"                    # AWS region where the S3 bucket is located
    acl            = "private"                      # Optional: Set access control for the state file
  }
}
