module "codebuild" {
  source                     = "./codebuild"
  project_name               = var.project_name
  region                     = var.region
  codebuild_service_role_arn = module.iam.codebuild_service_role_arn
  shared_artifacts_bucket    = module.s3.shared_artifacts_bucket
  lambda_functions_repo      = var.lambda_functions_repo
}

module "iam" {
  source                       = "./iam"
  project_name                 = var.project_name
  region                       = var.region
  shared_artifacts_bucket_name = module.s3.shared_artifacts_bucket
  codestarconnections_connection_arn = module.codepipeline.codestarconnections_connection_arn
}

module "codepipeline" {
  source                        = "./codepipeline"
  project_name                  = var.project_name
  region                        = var.region
  codepipeline_service_role_arn = module.iam.codepipeline_service_role_arn
  shared_artifacts_bucket       = module.s3.shared_artifacts_bucket
  aws_codebuild_project_name    = module.codebuild.aws_codebuild_project_name
  lambda_functions_repo_name    = var.lambda_functions_repo_name
  lambda_functions_repo         = var.lambda_functions_repo
}

module "s3" {
  source       = "./s3"
  project_name = var.project_name
  region       = var.region
}
