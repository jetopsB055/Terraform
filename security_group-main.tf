resource "aws_security_group" "ssh_access" {
  name        = "allow_ssh"
  description = "Security group to allow SSH access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "security_group_id" {
  value = aws_security_group.ssh_access.id
}
