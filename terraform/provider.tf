terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket         	   = "terraform-s3-state-npm"
    key                = "test-terraform.tfstate"
    region         	   = "eu-west-2"
    encrypt        	   = true
    dynamodb_table     = "mycomponents_tf_lockid"
    profile            = "default"
    skip_credentials_validation = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}