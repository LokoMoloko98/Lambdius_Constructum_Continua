output "codebuild_service_role_arn" {
  value = aws_iam_role.codebuild_role.arn
}

output "codepipeline_service_role_arn" {
  value = aws_iam_role.codepipeline_role.arn
}