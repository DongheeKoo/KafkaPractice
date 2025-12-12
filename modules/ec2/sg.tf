resource "aws_security_group" "main" {
  vpc_id      = var.vpc_id
  name        = "${var.env_prefix}-sg-kafka"
  
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "TCP"
  }

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["172.31.0.0/16"]
  }

  tags = {
    Name      = "${var.env_prefix}-sg-kafka"
    ManagedBy = "Terraform"
  }
}