# variables.tf - EN RAÍZ
variable "environment" {
  description = "Ambiente de despliegue"
  type        = string
  default     = "dev"
}