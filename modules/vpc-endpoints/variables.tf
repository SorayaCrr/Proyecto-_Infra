variable "project_name" {
  type    = string
  default = "abogados"
}

variable "environment" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}