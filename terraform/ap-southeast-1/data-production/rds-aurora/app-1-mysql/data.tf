data "terraform_remote_state" "data_production_vpc" {
  backend = "s3"
  config = {
    bucket = "digdat-terraform-state-storage"
    key    = "terraform/data-production/vpc/vpc-data-production.tfstate"
    region = "ap-southeast-1"
  }
}

data "terraform_remote_state" "production_vpc" {
  backend = "s3"
  config = {
    bucket = "digdat-terraform-state-storage"
    key    = "terraform/production/vpc/vpc-production.tfstate"
    region = "ap-southeast-1"
  }
}

data "terraform_remote_state" "control_plane_vpc" {
  backend = "s3"
  config = {
    bucket = "digdat-terraform-state-storage"
    key    = "terraform/control-plane/vpc/vpc-control-plane.tfstate"
    region = "ap-southeast-1"
  }
}