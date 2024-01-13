terraform {
  required_version = "1.6.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.0"
    }
  }


  backend "s3" {
    bucket = "breno500as-terraform-remote-state"
    key    = "aws-ec2-local-modules/terraform.tfstate"
    region = "us-east-1"
  }

}

provider "aws" {

  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "breno500as"
      managed-by = "terraform"

    }
  }
}

module "vpc" {
  source      = "./vpc"
  cidr_vpc    = "10.0.0.0/16"
  cidr_subnet = "10.0.1.0/24"
  environment = var.environment
}