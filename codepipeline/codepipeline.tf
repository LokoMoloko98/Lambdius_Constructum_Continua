data "aws_ssm_parameter" "github_pat" {
  name = "Github_PAT"
}

resource "aws_codepipeline" "lambdius-constructum-continua-lambda-codepipeline" {
  name     = "${var.project_name}-lambda-deployment-pipeline"
  role_arn = var.codepipeline_service_role_arn

  artifact_store {
    location = var.shared_artifacts_bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn        = aws_codestarconnections_connection.github_connection.arn
        FullRepositoryId     = var.lambda_functions_repo
        BranchName           = "Buildspec-Edits"
        OutputArtifactFormat = "CODEPIPELINE"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = var.aws_codebuild_project_name
        EnvironmentVariables = jsonencode([
          {
            name  = "SHARED_ARTIFACTS_BUCKET"
            value = var.shared_artifacts_bucket
            type  = "PLAINTEXT"
          },
          {
            name  = "COMMIT_ID"
            value = "#{Source.SourceIdentifier.CommitId}"
            type  = "PLAINTEXT"
          },
          {
            name  = "PREVIOUS_COMMIT_ID"
            value = "#{Source.SourceIdentifier.PreviousCommitId}"
            type  = "PLAINTEXT"
          }
        ])
      }
    }
  }

  #   stage {
  #     name = "Deploy"

  #         action {
  #             name            = "Deploy"
  #             category        = "Invoke"
  #             owner           = "AWS"
  #             provider        = "Lambda"
  #             version         = "1"
  #             input_artifacts = ["build_output"]

  #             configuration = {
  #             FunctionName = "your-deployment-helper-function"
  #             UserParameters = <<JSON
  #                 {
  #                 "bucket": "${var.shared_artifacts_bucket}",
  #                 "key": "lambda/changed_dirs.json"
  #                 }
  #             JSON
  #             }
  #         }
  #     }

  tags = {
    Name    = "${var.project_name}-pipeline"
    Project = var.project_name
  }
}
