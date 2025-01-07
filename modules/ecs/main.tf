module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = var.cluster_name

  cluster_service_connect_defaults = {
    namespace = aws_service_discovery_private_dns_namespace.this.arn
  }

  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/aws-ec2"
      }
    }
  }

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
    FARGATE_SPOT = {
      default_capacity_provider_strategy = {
        weight = 50
      }
    }
  }

  services = {
    ecsdemo-frontend = {
      cpu    = 1024
      memory = 4096

      # Container definition(s)
      container_definitions = {

        nginx = {
          cpu       = 512
          memory    = 1024
          essential = true
          image     = "public.ecr.aws/nginx/nginx:stable-perl"

          port_mappings = [
            {
              name          = "nginx"
              containerPort = 80
              protocol      = "tcp"
            }
          ]

          memory_reservation = 100
        }
      }

      service_connect_configuration = {
        service = {
          client_alias = {
            port     = 80
            dns_name = "nginx"
          }
          port_name      = "nginx"
          discovery_name = "nginx"
        }
      }

      #load_balancer = {
      #  service = {
      #    target_group_arn = "arn:aws:elasticloadbalancing:eu-west-1:1234567890:targetgroup/bluegreentarget1/209a844cd01825a4"
      #    container_name   = "ecs-sample"
      #    container_port   = 80
      #  }
      #}

      subnet_ids = flatten([var.private_subnets])
      security_group_rules = {
        alb_ingress_3000 = {
          type                     = "ingress"
          from_port                = 80
          to_port                  = 80
          protocol                 = "tcp"
          description              = "Service port"
          source_security_group_id = aws_security_group.ecs_sg.id
        }
        egress_all = {
          type        = "egress"
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
  }

  tags = {
    Environment = "Development"
    Project     = "Example"
  }
}
