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

variable "shared_artifacts_bucket_name" {
  description = "shared artifacts bucket name"
  type        = string
}

variable "shared_artifacts_bucket" {
  description = "shared artifacts bucket"
  type        = string  
  
}