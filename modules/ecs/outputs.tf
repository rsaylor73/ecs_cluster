output "cluster_arm" {
  value = module.ecs.cluster_arn
}

output "aws_security_group" {
  value = aws_security_group.ecs_sg.arn
}

