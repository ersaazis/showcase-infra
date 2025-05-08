# data.tf

data "aws_caller_identity" "current" {} # used for accesing Account ID and ARN

data "aws_ami" "ubuntu_24_04_lts" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

data "terraform_remote_state" "vpc_control_plane_production" {
  backend = "s3"
  config = {
    bucket  = "bwr-terraform-state-store-control-plane-bucket"
     key    = "terraform/aws/ap-northeast-1/control-plane/vpc/control-plane-production/terraform.tfstate"
    region  = "ap-northeast-1"
  }
}

data "terraform_remote_state" "iam_ec2_ssm_encrypted_session" {
  backend = "s3"
  config = {
    bucket = "bwr-terraform-state-store-control-plane-bucket"
    key    = "terraform/aws/ap-northeast-1/control-plane/iam/iam-ec2-ssm-encrypted-session/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

data "template_cloudinit_config" "proxy_production_init" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/cloud_init/basic_node_tuning.sh")
  }

  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/cloud_init/cloudWatch_agent.sh")
  }

  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/cloud_init/squid_init.sh")
  }
}
