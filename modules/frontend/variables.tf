#modules/frontend/variables.tf

variable "bucket_name" {
  description = "Nombre del bucket S3"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
    error_message = "El nombre del bucket debe ser válido."
  }
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "abogados"
}

variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
  default     = "dev"
}