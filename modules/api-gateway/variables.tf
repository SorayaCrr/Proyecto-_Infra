variable "project_name" {
  type = string
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "cognito_user_pool_arn" {
  type = string
}

variable "lambda_function_arn" {
  type = string
}

variable "lambda_function_invoke_arn" {
  type = string
}