module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.13.0"

  name    = var.cluster_name
  vpc_id  = var.vpc_id
  subnets = flatten([var.public_subnets])

  # Security Group
  security_group_ingress_rules = {
    all_http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      description = "HTTP web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "${var.private_subnets_cidr1}"
    }
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "${var.private_subnets_cidr2}"
    }
  }

  #access_logs = {
  #  bucket = "my-alb-logs"
  #}

  listeners = {
    http_tcp_listeners = {
      port               = "80"
      protocol           = "HTTP"
      #target_group_index = 0
    }
  }

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

  alb_name            = var.cluster_name
  alb_security_groups = var.security_group
  #certificate_arn     = ""
  health_check_path   = "/"
  region              = "us-east-1"
}
