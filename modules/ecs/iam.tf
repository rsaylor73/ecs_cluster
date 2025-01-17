resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_logging_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_logging_policy.arn
}

resource "aws_iam_policy" "ecs_logging_policy" {
  name        = "ecs_logging_policy"
  description = "Allows ECS tasks to send logs to CloudWatch"
  policy = data.aws_iam_policy_document.ecs_logging_policy.json
}

resource "aws_iam_role" "containerAppBuildProjectRole" {
  name = "containerAppBuildProjectRole"
  assume_role_policy = data.aws_iam_policy_document.containerAppBuildProjectRole.json
}

resource "aws_iam_role_policy" "containerAppBuildProjectRolePolicy" {
  role = aws_iam_role.containerAppBuildProjectRole.name
  policy = data.aws_iam_policy_document.containerAppBuildProjectRolePolicy.json
}

resource "aws_iam_role" "apps_codepipeline_role" {
  name               = "apps-code-pipeline-role"
  assume_role_policy = data.aws_iam_policy_document.apps_codepipeline_role.json
}

resource "aws_iam_role_policy" "apps_codepipeline_role_policy" {
  name   = "apps-codepipeline-role-policy"
  role   = aws_iam_role.apps_codepipeline_role.id
  policy = data.aws_iam_policy_document.apps_codepipeline_role_policy.json
}
