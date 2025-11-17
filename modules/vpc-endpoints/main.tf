# 1. VPC + Subred privada (2 AZ para alta disponibilidad)
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(var.tags, {
    Name = "${var.project_name}-${var.environment}-vpc"
  })
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = merge(var.tags, { Name = "private-a" })
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = merge(var.tags, { Name = "private-b" })
}

# 2. Security Group para Lambdas (solo salida a endpoints)
resource "aws_security_group" "lambda" {
  name        = "lambda-vpc-sg"
  vpc_id      = aws_vpc.main.id
  description = "Permitir solo salida HTTPS a VPC Endpoints"

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Sale por los endpoints de interfaz
  }

  tags = var.tags
}

# 3. VPC Endpoints Gateway (gratis y sin internet)
resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.us-east-1.dynamodb"
  route_table_ids = [
    aws_vpc.main.main_route_table_id
  ]
  tags = var.tags
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-east-1.s3"
  route_table_ids   = [aws_vpc.main.main_route_table_id]
  policy            = data.aws_iam_policy_document.s3_endpoint.json
  tags              = var.tags
}

# Política para que Lambdas accedan solo a sus buckets
data "aws_iam_policy_document" "s3_endpoint" {
  statement {
    effect    = "Allow"
    actions   = ["s3:*"]
    resources = ["*"]
  }
}

# 4. VPC Endpoints de interfaz (requieren SG y subred)
locals {
  interface_services = [
    "sns",
    "ses",
    "execute-api",      # Para invocar otras Lambdas si usan API interna
    "logs",
    "monitoring"
  ]
}

resource "aws_vpc_endpoint" "interface" {
  for_each = toset(local.interface_services)

  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.us-east-1.${each.value}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = [aws_subnet.private_a.id, aws_subnet.private_b.id]
  security_group_ids  = [aws_security_group.lambda.id]
  private_dns_enabled = true

  tags = merge(var.tags, { Name = "${each.value}-endpoint" })
}