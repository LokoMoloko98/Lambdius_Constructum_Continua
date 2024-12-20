# environment variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "codebuild_service_role_arn" {
  description = "CodeBuild service role arn"
  type        = string
}

variable "shared_artifacts_bucket" {
  description = "Shared artifacts bucket"
  type        = string

}

variable "lambda_functions_repo" {
  description = "Lambda functions repository"
  type        = string

}