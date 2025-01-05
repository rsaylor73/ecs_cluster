resource "aws_launch_template" "ecs_lt" {
  name_prefix   = "ecs-template"
  image_id      = var.ami_image
  instance_type = var.instance_type

  key_name               = "ec2ecsglog"
  vpc_security_group_ids = [var.security_group_id]
  iam_instance_profile {
    arn = aws_iam_instance_profile.ecs_profile.arn
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
      volume_type = "gp2"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ecs-instance"
    }
  }

  user_data = filebase64("${path.module}/ecs.sh")

}
