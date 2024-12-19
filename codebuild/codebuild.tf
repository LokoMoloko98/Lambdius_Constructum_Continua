resource "aws_codebuild_project" "lambda_codebuild" {
  name          = "lambda-functions-build"
  service_role  = var.codebuild_service_role_arn
  build_timeout = 30

  source {
    type            = "GITHUB"
    location        = "https://github.com/LokoMoloko98/mea-munera-lambda.git"
    git_clone_depth = 1
    buildspec       = <<-EOF
        version: 0.2

        phases:
          install:
            commands:
          pre_build:
            commands:
              - echo "Detecting changes in the repository..."
              - export CHANGED_DIRS=$(git diff --name-only HEAD~1 HEAD | awk -F'/' '{print $1}' | sort -u | uniq)
              - echo "Changed directories: $CHANGED_DIRS
          build:
            commands:
              - for DIR in $CHANGED_DIRS; do
                  echo "Processing $DIR...";
                  cd $DIR;
                  pip install -r requirements.txt -t .;  # Install requirements into the directory
                  zip -r function.zip .;  # Zip the entire directory
                  version=$(date +%Y%m%d%H%M%S)
                  aws s3 cp function.zip s3://${var.shared_artifacts_bucket}/lambda/$DIR/function-$version.zip;  # Upload zip to S3
                  cd ..;
                done
          post_build:
              commands:
              
        EOF
  }
  
   artifacts {
    type = "S3"
    location = var.shared_artifacts_bucket
    packaging = "ZIP"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:6.0"
    type         = "LINUX_CONTAINER"
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