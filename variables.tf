# environment variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "lambda_functions_repo" {
  description = "Lambda functions repository"
  type        = string
}

variable "lambda_functions_repo_name" {
  description = "Lambda functions repository name"
  type        = string
}