resource "aws_iam_role" "ec2-role" {
  assume_role_policy = data.aws_iam_policy_document.app-ec2-role.json

  description = "Allows EC2 instances to call AWS services on your behalf."
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/AmazonSNSFullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  ]

  max_session_duration = "3600"
  name                 = "ec2-role"
  path                 = "/"
}
