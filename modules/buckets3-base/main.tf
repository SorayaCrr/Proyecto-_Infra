# modules/buckets3-base/main.tf

# Bucket S3 base que todos los módulos usarán
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  
  # Prevención de eliminación accidental
  force_destroy = var.force_destroy
  
  tags = {
    Name        = var.bucket_name
    Project     = var.project_name
    Environment = var.environment
    Component   = "s3-base"
  }
}

# Bloquear acceso público del bucket (SEGURIDAD para todos)
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Encriptación por defecto (SEGURIDAD para todos)
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Versioning opcional
resource "aws_s3_bucket_versioning" "this" {
  count = var.enable_versioning ? 1 : 0
  
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"
  }
}