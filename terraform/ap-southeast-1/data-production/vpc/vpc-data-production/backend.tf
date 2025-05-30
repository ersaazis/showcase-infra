terraform {
  backend "s3" {
    bucket = "digdat-terraform-state-storage"
    key    = "terraform/data-production/vpc/vpc-data-production.tfstate"
    region = "ap-southeast-1"
    encrypt = true
    dynamodb_table = "terraform-locks"
    acl    = "bucket-owner-full-control"
  }
}
