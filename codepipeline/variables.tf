# environment variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "codepipeline_service_role_arn" {
  description = "codepipeline service role arn"
  type        = string
}

variable "shared_artifacts_bucket" {
  description = "shared artifacts bucket"
  type        = string
}

variable "aws_codebuild_project_name" {
  description = "codebuild service role name"
  type        = string

}

variable "lambda_functions_repo" {
  description = "lambda functions repository"
  type        = string
}

variable "lambda_functions_repo_name" {
  description = "Lambda functions repository name"
  type        = string
}