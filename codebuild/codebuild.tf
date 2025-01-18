resource "aws_codebuild_project" "lambdius-constructum-continua-codebuild" {
  name          = "${var.project_name}-lambda-functions-build"
  service_role  = var.codebuild_service_role_arn
  build_timeout = 30

  source {
    type            = "CODEPIPELINE"
    buildspec       = "buildspec.yaml"
  }

  artifacts {
    type      = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:6.0"
    type         = "LINUX_CONTAINER"
    environment_variable {
      name  = "SHARED_ARTIFACTS_BUCKET"
      value = var.shared_artifacts_bucket
    }
  }

  tags = {
    Name    = "${var.project_name}-lambda-functions-build"
    Project = var.project_name
  }
}
