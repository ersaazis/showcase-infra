data "aws_caller_identity" "current" {}

data "terraform_remote_state" "rds" {
  backend = "s3"

  config = {
    bucket         = "digdat-terraform-state-storage"
    key            = "terraform/data-production/rds-aurora/app-1-mysql.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

data "terraform_remote_state" "ec2_proxy" {
  backend = "s3"

  config = {
    bucket         = "digdat-terraform-state-storage"
    key            = "terraform/data-production/ec2/data-proxy.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
