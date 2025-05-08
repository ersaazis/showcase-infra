terraform {
  backend "s3" {
    bucket         = "digdat-terraform-state-storage"
    key            = "terraform/production/ec2/proxy-control-plane-data-production.tfstate"
    region         = "ap-southeast-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
    acl            = "bucket-owner-full-control"
  }
}
