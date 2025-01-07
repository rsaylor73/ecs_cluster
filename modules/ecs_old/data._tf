locals {
  account_id = data.aws_caller_identity.current.account_id
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "app-ec2-role" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com"
      ]
    }
  }
}
