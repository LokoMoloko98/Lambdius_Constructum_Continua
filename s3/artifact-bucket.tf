resource "aws_s3_bucket" "shared_artifacts_bucket" {
  bucket = "${var.project_name}-ci-artifacts"

  tags = {
    Name    = "${var.project_name}-ci-artifacts"
    Project = var.project_name
  }
}

resource "aws_s3_bucket_policy" "shared_artifacts_bucket_policy" {
  bucket = aws_s3_bucket.shared_artifacts_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        # Allow CodePipeline access
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
        Action = "s3:*"
        Resource = [
          "${aws_s3_bucket.shared_artifacts_bucket.arn}",
          "${aws_s3_bucket.shared_artifacts_bucket.arn}/*"
        ]
      },
      {
        # Allow CodeBuild access
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
        Action = "s3:*"
        Resource = [
          "${aws_s3_bucket.shared_artifacts_bucket.arn}",
          "${aws_s3_bucket.shared_artifacts_bucket.arn}/*"
        ]
      }
    ]
  })
}
