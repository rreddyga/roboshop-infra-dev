#always provider place in test module
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.33.0"
    }
  }
  backend "s3" {
    bucket  = "terraform-remote-state-aws-dev" # Replace with your unique bucket name
    key     = "roboshop-dev-vpc"
    region  = "us-east-1"
    encrypt = true
    use_lockfile   = true
  }
}

provider "aws" {
  # Configuration options to provide the region
  region = "us-east-1"
}