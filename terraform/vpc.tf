module "vpc" {
  source                = "./modules/vpc"
  environment           = var.environment
  vpc_cidr              = var.vpc_cidr
  region                = var.region
  private_subnet_cidr   = var.private_subnet_cidr
  private_subnet_cidr_2 = var.private_subnet_cidr_2
  public_subnet_cidr    = var.public_subnet_cidr
  app                   = var.app
  availability_zone_a   = var.availability_zone_a
  availability_zone_b   = var.availability_zone_b
}