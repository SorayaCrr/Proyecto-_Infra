# outputs.tf - EN RAÍZ
output "frontend_url" {
  description = "URL pública del frontend"
  value       = module.frontend.cloudfront_domain
}

output "s3_bucket_name" {
  description = "Nombre del bucket S3 del frontend"
  value       = module.frontend.bucket_name
}

output "cloudfront_distribution_id" {
  description = "ID de la distribución CloudFront"
  value       = module.frontend.cloudfront_id
}