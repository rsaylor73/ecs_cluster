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

data "aws_iam_policy_document" "apps_codepipeline_role" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "codepipeline.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "apps_codepipeline_role_policy" {
  statement {
    actions = [
      "iam:PassRole"
    ]
    effect = "Allow"
    resources = ["*"]
    condition {
      test     = "StringEqualsIfExists"
      variable = "iam:PassedToService"
      values   = [
        "cloudformation.amazonaws.com",
        "elasticbeanstalk.amazonaws.com",
        "ec2.amazonaws.com",
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
  statement {
    actions = [
      "codecommit:CancelUploadArchive",
      "codecommit:GetBranch",
      "codecommit:GetCommit",
      "codecommit:GetRepository",
      "codecommit:GetUploadArchiveStatus",
      "codecommit:UploadArchive"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "codedeploy:CreateDeployment",
      "codedeploy:GetApplication",
      "codedeploy:GetApplicationRevision",
      "codedeploy:GetDeployment",
      "codedeploy:GetDeploymentConfig",
      "codedeploy:RegisterApplicationRevision"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "codestar-connections:UseConnection"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "elasticbeanstalk:*",
      "ec2:*",
      "elasticloadbalancing:*",
      "autoscaling:*",
      "cloudwatch:*",
      "s3:*",
      "sns:*",
      "cloudformation:*",
      "rds:*",
      "sqs:*",
      "ecs:*"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "lambda:InvokeFunction",
      "lambda:ListFunctions"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "opsworks:CreateDeployment",
      "opsworks:DescribeApps",
      "opsworks:DescribeCommands",
      "opsworks:DescribeDeployments",
      "opsworks:DescribeInstances",
      "opsworks:DescribeStacks",
      "opsworks:UpdateApp",
      "opsworks:UpdateStack"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "cloudformation:CreateStack",
      "cloudformation:DeleteStack",
      "cloudformation:DescribeStacks",
      "cloudformation:UpdateStack",
      "cloudformation:CreateChangeSet",
      "cloudformation:DeleteChangeSet",
      "cloudformation:DescribeChangeSet",
      "cloudformation:ExecuteChangeSet",
      "cloudformation:SetStackPolicy",
      "cloudformation:ValidateTemplate"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
      "codebuild:BatchGetBuildBatches",
      "codebuild:StartBuildBatch"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "devicefarm:ListProjects",
      "devicefarm:ListDevicePools",
      "devicefarm:GetRun",
      "devicefarm:GetUpload",
      "devicefarm:CreateUpload",
      "devicefarm:ScheduleRun"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "servicecatalog:ListProvisioningArtifacts",
      "servicecatalog:CreateProvisioningArtifact",
      "servicecatalog:DescribeProvisioningArtifact",
      "servicecatalog:DeleteProvisioningArtifact",
      "servicecatalog:UpdateProduct"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "cloudformation:ValidateTemplate"
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
      "states:DescribeExecution",
      "states:DescribeStateMachine",
      "states:StartExecution"
    ]
    effect = "Allow"
    resources = ["*"]
  }
  statement {
    actions = [
      "appconfig:StartDeployment",
      "appconfig:StopDeployment",
      "appconfig:GetDeployment"
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
