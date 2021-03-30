resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.environment}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Environment = var.environment
  }
}

resource "aws_db_instance" "rds" {
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.id
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  name                   = var.name
  username               = var.username
  password               = var.password
  identifier             = "${var.environment}-database"
  allocated_storage      = var.allocated_storage
  depends_on             = [aws_db_subnet_group.db_subnet_group]
  skip_final_snapshot    = var.skip_final_snapshot
  vpc_security_group_ids = [var.db_security_group_id]
}