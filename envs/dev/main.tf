terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

module "vpc" {
  source = "../../modules/vpc"
  vpc_name = "KafkaPractice"
  vpc_cidr = "10.1.0.0/16"
  public_subnets = {
    public-subnet-1 = {
      cidr_block = "10.1.0.0/18"
      availability_zone = "ap-northeast-2a"
    }
    public-subnet-1 = {
      cidr_block = "10.1.64.0/18"
      availability_zone = "ap-northeast-2b"
    }
  }
}
