resource "aws_codebuild_project" "lambdius-constructum-continua-codebuild" {
  name          = "${var.project_name}-lambda-functions-build"
  service_role  = var.codebuild_service_role_arn
  build_timeout = 30

  source {
    type            = "GITHUB"
    location        = var.lambda_functions_repo
    git_clone_depth = 1
    buildspec       = "buildspec.yaml"
  }

  artifacts {
    type      = "S3"
    location  = var.shared_artifacts_bucket
    packaging = "ZIP"
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

data "aws_ssm_parameter" "github_pat" {
  name = "Github_PAT"
}

resource "aws_codebuild_source_credential" "codebuild_github_credential" {
  auth_type   = "PERSONAL_ACCESS_TOKEN"
  server_type = "GITHUB"
  token       = data.aws_ssm_parameter.github_pat.value
}
