variable "cluster_name" {}
variable "vpc_cidr" {}
variable "private_subnets_cidr1" {}
variable "private_subnets_cidr2" {}
variable "public_subnet_cidr1" {}
variable "public_subnet_cidr2" {}

variable "ecr_repository" {}
variable "logs_group" {}
variable "region" {}
variable "asg_min_capacity" {}
variable "asg_max_capacity" {}
variable "cpu_target_value" {}
variable "scale_in_cooldown" {}
variable "scale_out_cooldown" {}
variable "cpu_target_value_si" {}
variable "scale_in_cooldown_si" {}
variable "scale_out_cooldown_si" {}
