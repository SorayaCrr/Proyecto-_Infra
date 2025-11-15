# modules/buckets3-base/variables.tf

 variable "bucket_name" {
  description = "Nombre único del bucket S3"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9.-]{3,63}$", var.bucket_name))
    error_message = "El nombre del bucket debe ser válido para S3."
  }
}

variable "project_name" {
  description = "Nombre del proyecto para tagging"
  type        = string
  default     = "abogados"
}

variable "environment" {
  description = "Ambiente (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "force_destroy" {
  description = "Forzar destrucción del bucket incluso con contenido"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Habilitar versioning de objetos"
  type        = bool
  default     = false
}