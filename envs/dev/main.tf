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

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  env_prefix = "KafkaPractice"

  ami = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.medium"
}

module "vpc" {
  source = "../../modules/vpc"
  vpc_name = local.env_prefix
  vpc_cidr = "10.1.0.0/16"
  public_subnets = {
    public-subnet-1 = {
      cidr_block = "10.1.0.0/18"
      availability_zone = "ap-northeast-2a"
    }
    public-subnet-2 = {
      cidr_block = "10.1.64.0/18"
      availability_zone = "ap-northeast-2c"
    }
  }
}

module "ec2" {
  source = "../../modules/ec2"
  env_prefix = local.env_prefix
  vpc_id     = module.vpc.vpc_id
  ec2_instances = {
    peter-zk01 = {
      ami = local.ami
      instance_type = local.instance_type
      subnet_id = module.vpc.public_subnet_ids[0]
      associate_public_ip_address = true
    }
    peter-zk02 = {
      ami = local.ami
      instance_type = local.instance_type
      subnet_id = module.vpc.public_subnet_ids[0]
      associate_public_ip_address = true
    }
    peter-zk03 = {
      ami = local.ami
      instance_type = local.instance_type
      subnet_id = module.vpc.public_subnet_ids[1]
      associate_public_ip_address = true
    }

    peter-kafka01 = {
      ami = local.ami
      instance_type = local.instance_type
      subnet_id = module.vpc.public_subnet_ids[0]
      associate_public_ip_address = true
    }
    peter-kafka02 = {
      ami = local.ami
      instance_type = local.instance_type
      subnet_id = module.vpc.public_subnet_ids[0]
      associate_public_ip_address = true
    }
    peter-kafka03 = {
      ami = local.ami
      instance_type = local.instance_type
      subnet_id = module.vpc.public_subnet_ids[1]
      associate_public_ip_address = true
    }

    peter-ansible01 = {
      ami = local.ami
      instance_type = local.instance_type
      subnet_id = module.vpc.public_subnet_ids[1]
      associate_public_ip_address = true
    }
  }
}
