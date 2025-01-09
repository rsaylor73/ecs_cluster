data "aws_iam_policy_document" "containerAppBuildProjectRole" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "codebuild.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "containerAppBuildProjectRolePolicy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "ec2:CreateNetworkInterfacePermission"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "s3:*"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "ecr:*"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "ecs:*"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "ssm:DescribeParameters",
      "ssm:GetParameters"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "kms:Decrypt"
    ]
    effect = "Allow"
    resources = ["*"]
  }


}
