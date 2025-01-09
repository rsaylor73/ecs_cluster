cluster_name="ecs-demo"
vpc_cidr="10.1.0.0/16"
private_subnets_cidr1="10.1.1.0/24"
private_subnets_cidr2="10.1.2.0/24"
public_subnet_cidr1="10.1.3.0/24"
public_subnet_cidr2="10.1.4.0/24"

ecr_repository="public.ecr.aws/nginx/nginx:stable-perl"
logs_group="/ecs/test"
region="us-east-1"
asg_min_capacity="1"
asg_max_capacity="10"
cpu_target_value="80.0"
scale_in_cooldown="300"
scale_out_cooldown="300"
cpu_target_value_si="20"
scale_in_cooldown_si="300"
scale_out_cooldown_si="300"
artifacts_bucket_name="cicd-artifacts-bucket"
repository_branch="main"
github_repo="rsaylor73/hello-world-ecs"
