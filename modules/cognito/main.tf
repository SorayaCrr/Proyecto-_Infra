resource "aws_cognito_user_pool" "main" {
  name = "${var.project_name}-${var.environment}-user-pool"

  schema {
    name                = "email"
    attribute_data_type = "String"
    mutable             = true
    required            = true
  }

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_uppercase = true
    require_numbers   = true
    require_symbols   = false
  }

  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_cognito_user_pool_client" "main" {
  name = "${var.project_name}-${var.environment}-app-client"

  user_pool_id = aws_cognito_user_pool.main.id

  generate_secret = false
}