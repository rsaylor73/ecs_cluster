resource "aws_service_discovery_private_dns_namespace" "app" {
  name        = "app.local"
  vpc         = var.vpc_id
  description = "Private DNS namespace for app services"
}

resource "aws_service_discovery_service" "nginx" {
  name = "nginx"

  dns_config {
    namespace_id   = aws_service_discovery_private_dns_namespace.app.id
    routing_policy = "MULTIVALUE"

    dns_records {
      ttl  = 10
      type = "A"
    }
  }
}
