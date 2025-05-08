# providers.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.50"
    }
  }

  #Fill in these values after backend has been created
  backend "s3" {
    bucket         = "bwr-terraform-state-store-control-plane-bucket"
    dynamodb_table = "bwr-terraform-state-store-control-plane-table"
    key            = "terraform/aws/ap-northeast-1/control-plane/ec2/proxy-production/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    kms_key_id     = "alias/bwr-terraform-state-store-control-plane-table-kms-key"
  }
}

provider "aws" {
  region = var.aws_region
}
