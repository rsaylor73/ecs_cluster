resource "aws_codestarconnections_connection" "github" {
  name          = "github-connection"
  provider_type = "GitHub"
}

resource "aws_codepipeline" "app_pipeline" {
  name     = "hello-world-cicd-pipeline"
  role_arn = aws_iam_role.apps_codepipeline_role.arn

  artifact_store {
    location = module.cicd_bucket.s3_bucket_id
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      category = "Source"

      configuration = {
        BranchName = var.repository_branch
        ConnectionArn = aws_codestarconnections_connection.github.arn
        FullRepositoryId = var.github_repo
      }

      input_artifacts = []

      name              = "Source"
      output_artifacts  = ["SourceArtifact"]
      owner             = "AWS"
      provider          = "CodeStarSourceConnection"
      run_order         = 1
      version           = "1"
      region            = var.region
    }
  }

  stage {
    name = "Build"

    action {
      category = "Build"

      configuration = {
        ProjectName = aws_codebuild_project.containerAppBuild.name
        EnvironmentVariables = jsonencode(
          [
            {
              name  = "environment"
              type  = "PLAINTEXT"
              value = "dev"
            },
            {
              name  = "AWS_DEFAULT_REGION"
              type  = "PLAINTEXT"
              value = var.region
            },
            {
              name  = "AWS_ACCOUNT_ID"
              type  = "PARAMETER_STORE"
              value = local.account_id
            },
            {
              name  = "IMAGE_REPO_NAME"
              type  = "PLAINTEXT"
              value = aws_ecr_repository.app_repo.name
            },
            {
              name  = "IMAGE_TAG"
              type  = "PLAINTEXT"
              value = "latest"
            },
            {
              name  = "CONTAINER_NAME"
              type  = "PLAINTEXT"
              value = var.container_name
            },
          ]
        )
      }

      input_artifacts  = ["SourceArtifact"]
      name             = "Build"
      namespace        = "BuildVariables"
      output_artifacts = ["BuildArtifact"]
      owner            = "AWS"
      provider         = "CodeBuild"
      region           = var.region
      run_order        = "1"
      version          = "1"
    }
  }

  stage {
    name = "Deploy"

    action {
      category = "Deploy"
      configuration = {
        ClusterName = aws_ecs_cluster.my_cluster.name
        ServiceName = aws_ecs_service.nginx_service.name
        FileName    = "imagedefinitions.json"
      }
      input_artifacts = [
        "BuildArtifact",
      ]
      name             = "Deploy"
      output_artifacts = []
      owner            = "AWS"
      provider         = "ECS"
      run_order        = 1
      version          = "1"
    }
  }

  depends_on = [
    aws_codebuild_project.containerAppBuild,
    aws_ecs_cluster.my_cluster,
    aws_ecs_service.nginx_service,
    aws_ecr_repository.app_repo,
    module.cicd_bucket
  ]

}
