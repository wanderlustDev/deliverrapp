module "rds" {
  source               = "./modules/rds"
  environment          = var.environment
  private_subnet_ids   = module.vpc.subnet_ids
  allocated_storage    = var.rds_allocated_storage
  engine               = var.rds_engine
  engine_version       = var.rds_engine_version
  instance_class       = var.rds_instance_class
  name                 = var.rds_name
  password             = var.rds_password
  username             = var.rds_username
  db_security_group_id = aws_security_group.rds.id
  skip_final_snapshot  = var.rds_skip_final_snapshot
}