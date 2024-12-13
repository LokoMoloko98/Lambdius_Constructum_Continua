module "codebuild" {
  source            = "./codebuild"
  project_name      = var.project_name
  region            = var.region
  codebuild_service_role_arn = var.codebuild_service_role_arn
  codebuild_service_role_name = var.codebuild_service_role_name
  lambda_bucket_name = var.lambda_bucket_name
  github_pat = var.github_pat
}

module "iam" {
  source       = "./iam"
  project_name = var.project_name
  region       = var.region
}

module "codepipeline" {
  source            = "./codepipeline"
  project_name      = var.project_name
  region            = var.region
  artifact_store    = var.artifact_store
  service_role_arn  = var.service_role_arn
}

module "s3" {
  source            = "./s3"
  project_name      = var.project_name
  region            = var.region
  codepipeline_bucket_name = var.codepipeline_bucket_name
  build_artifacts_bucket_name = var.build_artifacts_bucket_name
  
}