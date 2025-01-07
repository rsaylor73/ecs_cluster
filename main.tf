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
}

#module "ecs" {
#  source = "modules/ecs_old"
#  security_group_id = module.vpc.security_group_id
#  ami_image = var.ami_image
#  instance_type = var.instance_type
#  private_subnets = module.vpc.private_subnets
#  desired_capacity = var.desired_capacity
#  max_size = var.max_size
#  min_size = var.min_size
#  vpc_id = module.vpc.vpc_id
#  cluster_name = var.cluster_name
#  private_subnet_ids = module.vpc.private_subnet_ids
#}
