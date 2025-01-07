module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 9.13"

  name = "${var.cluster_name}-alb"

  load_balancer_type = "application"

  vpc_id  = var.vpc_id
  subnets = flatten([var.public_subnets])
  security_group_rules = {
    ingress_all_http = {
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP web traffic"
      cidr_blocks = ["0.0.0.0/0"]
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [var.private_subnets_cidr1]
    }
    egress_all = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = [var.private_subnets_cidr2]
    }
  }

  http_tcp_listeners = [
    {
      port               = "80"
      protocol           = "HTTP"
      target_group_index = 0
    },
  ]

  target_groups = [
    {
      name             = "${var.cluster_name}-tg"
      backend_protocol = "HTTP"
      backend_port     = "80"
      target_type      = "ip"
      health_check = {
        path    = "/"
        port    = "80"
        matcher = "200-299"
      }
    },
  ]

}
