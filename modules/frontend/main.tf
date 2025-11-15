# modules/frontend/main.tf

# S3 Bucket
module "s3_base" {
  source = "../s3-base"
  
  bucket_name        = var.bucket_name
  project_name       = var.project_name
  environment        = var.environment
  force_destroy      = false
  enable_versioning  = false
}

# OAC
resource "aws_cloudfront_origin_access_control" "frontend_oac" {
  name                              = "${var.project_name}-frontend-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CloudFront
resource "aws_cloudfront_distribution" "frontend_cdn" {
  enabled             = true
  default_root_object = "index.html"
  
  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
  }

  origin {
    domain_name              = module.s3_base.bucket_regional_domain_name
    origin_id                = "s3-frontend-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.frontend_oac.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-frontend-origin"
    viewer_protocol_policy = "redirect-to-https"
    compress         = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name        = "${var.project_name}-frontend-cdn"
    Project     = var.project_name
    Environment = var.environment
    Component   = "frontend"
  }
}

# Policy del bucket 
resource "aws_s3_bucket_policy" "frontend_bucket_policy" {
  bucket = module.s3_base.bucket_id  # ✅ CORREGIDO
  depends_on = [module.s3_base]  # ✅ CORREGIDO

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipalReadOnly"
        Effect    = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action = "s3:GetObject"
        Resource = "${module.s3_base.bucket_arn}/*"  # ✅ CORREGIDO
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.frontend_cdn.arn
          }
        }
      }
    ]
  })
}