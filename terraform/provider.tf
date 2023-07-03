terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket         	   = "terraform-s3-state-npm"
    key                = "state/terraform.tfstate"
    region         	   = "eu-west-2"
    #encrypt        	   = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}