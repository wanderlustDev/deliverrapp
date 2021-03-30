module "eb" {
  source                = "./modules/eb"
  app                   = var.app
  app_s3_bucket         = aws_s3_bucket.app_bucket.id
  app_s3_bucket_key     = aws_s3_bucket_object.app_jar.id
  environment           = var.environment
  iam_instance_profile  = aws_iam_instance_profile.eb_instance_profile.name
  ec2_instance_type     = var.ec2_instance_type
  ec2_security_group    = aws_security_group.default.id
  vpc_id                = module.vpc.vpc_id
  public_subnet_id      = module.vpc.public_subnet_id
  service_role          = aws_iam_role.eb_service_role.name
}