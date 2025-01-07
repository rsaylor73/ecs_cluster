module "vpc" {
  source = "./modules/vpc"
  cluster_name = var.cluster_name
  vpc_cidr = var.vpc_cidr
  private_subnets_cidr1 = var.private_subnets_cidr1
  private_subnets_cidr2 = var.private_subnets_cidr2
  public_subnet_cidr1 = var.public_subnet_cidr1
  public_subnet_cidr2 = var.public_subnet_cidr2
}

module "ecs" {
  source = "./modules/ecs"
  cluster_name = var.cluster_name
  private_subnets = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id
  target_groups = module.alb.target_group
}

module "alb" {
  source = "./modules/alb"
  cluster_name = var.cluster_name
  private_subnets_cidr1 = var.private_subnets_cidr1
  private_subnets_cidr2 = var.private_subnets_cidr2
  public_subnets = module.vpc.public_subnets
  vpc_id = module.vpc.vpc_id
  security_group = module.ecs.aws_security_group
}
