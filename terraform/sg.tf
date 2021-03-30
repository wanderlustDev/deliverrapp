/*====
VPC's Default Security Group
======*/
resource "aws_security_group" "default" {
  name        = "${var.environment}-default-sg"
  description = "Default security group to allow inbound/outbound from the VPC"
  vpc_id      = module.vpc.vpc_id
  depends_on  = [module.vpc]

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Telnet"
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All"
  }

  tags = {
    Environment = var.environment
  }
}

/*====
VPC's Default Security Group for Private RDS
======*/
resource "aws_security_group" "rds" {
  name        = "${var.environment}-rds-sg"
  description = "Security group to allow inbound/outbound from the VPC to RDS"
  vpc_id      = module.vpc.vpc_id
  depends_on  = [module.vpc]

  ingress {
    from_port       = "5432"
    to_port         = "5432"
    protocol        = "tcp"
    description     = "postgres"
    security_groups = [aws_security_group.default.id]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    description = "All"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Environment = var.environment
  }
}