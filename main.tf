#main.tf

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.21.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}

# Módulo de frontend
module "frontend" {
  source       = "./modules/frontend"
  bucket_name  = "abogados-frontend-pablo"
  project_name = "abogados"
  environment  = "dev"
}