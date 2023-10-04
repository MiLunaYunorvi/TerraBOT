terraform {
  required_providers {
    aws = {
    source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}
variable "db_password" {
  sensitive = true
}

module "SecuBotModule" {
  source = "./modules"
  DB_password = var.db_password
}