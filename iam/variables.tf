# environment variables
variable "region" {
  description = "region to create resources"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "shared_artifacts_bucket_name" {
  description = "CodePipeline bucket name"
  type        = string
}