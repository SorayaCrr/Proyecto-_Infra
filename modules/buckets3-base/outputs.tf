# modules/buckets3-base/outputs.tf

output "bucket_id" {
  description = "ID del bucket S3"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "ARN del bucket S3"
  value       = aws_s3_bucket.this.arn
}

output "bucket_domain_name" {
  description = "Domain name del bucket S3"
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "bucket_regional_domain_name" {
  description = "Regional domain name del bucket S3"
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}