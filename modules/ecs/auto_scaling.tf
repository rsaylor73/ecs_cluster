resource "aws_appautoscaling_target" "ecs_service" {
  max_capacity       = var.asg_max_capacity
  min_capacity       = var.asg_min_capacity
  resource_id        = "service/${var.cluster_name}/nginx-service"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "scale_out" {
  name               = "${var.cluster_name}-scale-out"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_service.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_service.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_service.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = var.cpu_target_value  # Target CPU utilization (80%)
    scale_in_cooldown  = var.scale_in_cooldown   # Scale in after 5 minutes
    scale_out_cooldown = var.scale_out_cooldown   # Scale out after 5 minutes

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

resource "aws_appautoscaling_policy" "scale_in" {
  for_each           = toset(local.services)
  name               = "${var.cluster_name}-scale-in"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_service.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_service.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_service.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = var.cpu_target_value_si  # Lower target CPU utilization (20%)
    scale_in_cooldown  = var.scale_in_cooldown_si
    scale_out_cooldown = var.scale_out_cooldown_si

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}
