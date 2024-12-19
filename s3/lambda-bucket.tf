resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "${var.project_name}-lambda-deployment"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "${var.project_name}-lambda-deployment"
  }
}

resource "aws_s3_bucket_policy" "lambda_bucket_policy" {
  bucket = aws_s3_bucket.lambda_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        # Allow Lambda service to access deployment artifacts
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = [
          "${aws_s3_bucket.lambda_bucket.arn}",
          "${aws_s3_bucket.lambda_bucket.arn}/*"
        ]
      },
      {
        # Allow CodeBuild to upload Lambda artifacts
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
        Action   = "s3:PutObject"
        Resource = "${aws_s3_bucket.lambda_bucket.arn}/*"
      }
    ]
  })
}
