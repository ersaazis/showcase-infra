terraform {
  backend "s3" {
    bucket         = "digdat-terraform-state-storage"
    key            = "terraform/vpc-peering/vpc-peering-production-data-production.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
    acl            = "bucket-owner-full-control"
  }
}
