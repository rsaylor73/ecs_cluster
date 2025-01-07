data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}

locals {
  name   = "core-infra"

  tags = {
    Blueprint  = local.name
    GithubRepo = "github.com/aws-ia/ecs-blueprints"
  }
}

resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = "default.${local.name}.local"
  description = "Service discovery namespace.clustername.local"
  vpc         = var.vpc_id

  tags = local.tags
}
