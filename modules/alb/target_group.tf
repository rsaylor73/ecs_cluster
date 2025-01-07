resource "aws_lb_target_group" "target_group" {
  name        = var.cluster_name
  # 32 character max-length
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  #slow_start  = var.target_group_slow_start

  health_check {
    path     = "/"
    protocol = "HTTP"
    interval = 60
  }
}
