# environment variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "codepipeline_bucket_name" {
  description = "CodePipeline bucket name"
  type        = string
  
}

variable "build_artifacts_bucket_name" {
  description = "Build artifacts bucket name"
  type        = string
}