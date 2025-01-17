output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "security_group_id" {
  value = aws_security_group.security_group.id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_objects
}
