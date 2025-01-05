cluster_name="ecs-demo"
vpc_cidr="10.1.0.0/16"
private_subnets_cidr1="10.1.1.0/24"
private_subnets_cidr2="10.1.2.0/24"
public_subnet_cidr1="10.1.3.0/24"
public_subnet_cidr2="10.1.4.0/24"

ami_image="ami-062c116e449466e7f"
instance_type="t3.micro"
desired_capacity=2
max_size=3
min_size=1
