resource "aws_codestarconnections_connection" "github" {
  name          = "github-connection"
  provider_type = "GitHub"
}

resource "aws_codepipeline" "app_pipeline" {
  name     = "hello-world-cicd-pipeline"
  role_arn = aws_iam_role.apps_codepipeline_role.arn

  artifact_store {
    location = var.artifacts_bucket_name
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
        ProjectName = var.cluster_name
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



}
