output "shared_artifacts_bucket" {
  value = aws_s3_bucket.shared_artifacts_bucket.bucket
}

output "shared_artifacts_bucket_name" {
  value = aws_s3_bucket.shared_artifacts_bucket.name
}