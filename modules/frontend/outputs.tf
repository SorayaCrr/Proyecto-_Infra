#modules/frontend/outputs.tf

output "cloudfront_domain" {
  description = "Dominio de CloudFront"
  value       = aws_cloudfront_distribution.frontend_cdn.domain_name
}

output "bucket_name" {
  description = "Nombre del bucket S3"
  value       = module.s3_base.bucket_id
}

output "cloudfront_id" {
  description = "ID de la distribución CloudFront"
  value       = aws_cloudfront_distribution.frontend_cdn.id
}

output "s3_bucket_arn" {
  description = "ARN del bucket S3"
  value       = module.s3_base.bucket_arn
}