terraform {
  backend "s3" {
    bucket = "digdat-terraform-state-storage"
    key    = "terraform/control-plane/vpc/vpc-control-plane.tfstate"
    region = "ap-southeast-1"
    encrypt = true
    dynamodb_table = "terraform-locks"
    acl    = "bucket-owner-full-control"
  }
}
