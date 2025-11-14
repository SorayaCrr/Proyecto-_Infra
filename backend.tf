terraform {
  backend "s3" {
    bucket         = "abogados-tfstate"  # Crea bucket manualmente primero.
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"   # Para locking concurrente.
  }
}