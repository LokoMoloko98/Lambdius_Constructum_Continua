# resource "aws_codepipeline" "lambda_pipeline" {
#   name     = "lambda-deployment-pipeline"
#   role_arn = aws_iam_role.codepipeline_role.arn

#   artifact_store {
#     location = aws_s3_bucket.codepipeline_bucket.bucket
#     type     = "S3"
#   }

#   stage {
#     name = "Source"

#     action {
#       name             = "Source"
#       category         = "Source"
#       owner            = "AWS"
#       provider         = "CodeCommit"
#       version          = "1"
#       output_artifacts = ["source_output"]

#       configuration = {
#         RepositoryName = "Lambdius_Constructum_Continua"
#         BranchName     = "main"
#       }
#     }
#   }

#   stage {
#     name = "Build"

#     action {
#       name             = "Build"
#       category         = "Build"
#       owner            = "AWS"
#       provider         = "CodeBuild"
#       version          = "1"
#       input_artifacts  = ["source_output"]
#       output_artifacts = ["build_output"]

#       configuration = {
#         ProjectName = aws_codebuild_project.lambda_build.name
#       }
#     }
#   }

#   stage {
#     name = "Deploy"

#     action {
#       name             = "Deploy"
#       category         = "Deploy"
#       owner            = "AWS"
#       provider         = "Lambda"
#       version          = "1"
#       input_artifacts  = ["build_output"]

#       configuration = {
#         FunctionName = "YOUR_LAMBDA_FUNCTION_NAME"
#       }
#     }
#   }
# }