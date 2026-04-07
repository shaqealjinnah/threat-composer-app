module "networking" {
  source = "./modules/networking"

  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  availability_zones  = var.availability_zones
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "security" {
  source = "./modules/security"

  project_name = var.project_name
  vpc_id       = module.networking.vpc_id
}

module "alb" {
  source = "./modules/alb"

  project_name      = var.project_name
  vpc_id            = module.networking.vpc_id
  alb_sg_id         = module.security.alb_sg_id
  public_subnet_ids = module.networking.public_subnet_ids
  acm_arn           = module.acm.acm_arn
  container_port    = var.container_port
}

module "acm" {
  source = "./modules/acm" 

  project_name      = var.project_name
  domain_name       = var.domain_name
}