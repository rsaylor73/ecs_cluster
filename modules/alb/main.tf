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

  #listeners = {
  #  http_tcp_listeners = {
  #    port               = "80"
  #    protocol           = "HTTP"
  #    forward = {
  #      target_group_key = "container"
  #    }
  #  }
  #}

  #target_groups = {
  #  container = {
  #    name_prefix      = "h1"
  #    protocol         = "HTTP"
  #    port             = 80
  #    target_id        = ""
  #  }
  #}


}
