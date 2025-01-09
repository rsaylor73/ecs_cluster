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
  ecr_repository = var.ecr_repository
  logs_group = var.logs_group
  region = var.region
  private_subnets = module.vpc.private_subnets
  vpc_id = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  asg_min_capacity = var.asg_min_capacity
  asg_max_capacity = var.asg_max_capacity
  cpu_target_value = var.cpu_target_value
  scale_in_cooldown = var.scale_in_cooldown
  scale_out_cooldown = var.scale_out_cooldown
  cpu_target_value_si = var.cpu_target_value_si
  scale_in_cooldown_si = var.scale_in_cooldown_si
  scale_out_cooldown_si = var.scale_out_cooldown_si
  artifacts_bucket_name = var.artifacts_bucket_name
  github_repo = var.github_repo
  repository_branch = var.repository_branch
  container_name = var.container_name
}
