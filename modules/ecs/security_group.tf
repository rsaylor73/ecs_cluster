resource "aws_security_group" "ecs_sg" {
  vpc_id      = var.vpc_id
  name        = "ecs-sg"
  description = "ecs-sg"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH - Robert"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["47.195.201.144/32"]
  }

  tags = {
    Name = "ecs-sg"
  }
}
