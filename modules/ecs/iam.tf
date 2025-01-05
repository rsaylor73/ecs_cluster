resource "aws_iam_role" "ec2-role" {
  assume_role_policy = data.aws_iam_policy_document.app-ec2-role.json
  description          = "Allows EC2 instances to call AWS services on your behalf."
  max_session_duration = "3600"
  name                 = "ec2-role"
  path                 = "/"
}

resource "aws_iam_role_policy_attachments_exclusive" "ec2-role" {
  role_name   = aws_iam_role.ec2-role.name
  policy_arns = [
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
}

resource "aws_iam_instance_profile" "ecs_profile" {
  name = "EcsInstanceProfile"
  role = aws_iam_role.ec2-role.name
}
