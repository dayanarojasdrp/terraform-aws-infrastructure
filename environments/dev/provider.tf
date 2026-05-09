terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket       = "my-terraform-state-bucket"   # nombre exacto de tu bucket
    key          = "terraform/state.tfstate"     # ruta dentro del bucket
    region       = "us-west-2"                   # región real del bucket
    encrypt      = true
    use_lockfile = true                           # reemplaza dynamodb_table
  }
}

provider "aws" {
  region = var.aws_region
}
