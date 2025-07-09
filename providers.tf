terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0"

    }
  }
}

# Provider for the Primary Region 
provider "aws" {
  alias  = "primary"
  region = var.primary_region
}
#Provider for the secondary region
provider "aws" {
  alias  = "secondary"
  region = var.secondary_region
}


