# environment variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "codebuild_service_role_name" {
  description = "CodeBuild service role name"
  type        = string
}

variable "codebuild_service_role_arn" {
  description = "CodeBuild service role arn"
  type        = string
}

variable "lambda_bucket_name" {
  description = "Lambda bucket name"
  type        = string
  
}