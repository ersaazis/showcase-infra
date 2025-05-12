data "aws_ami" "ubuntu_24_04_lts" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

data "terraform_remote_state" "data_production_vpc" {
  backend = "s3"
  config = {
    bucket = "digdat-terraform-state-storage"
    key    = "terraform/data-production/vpc/vpc-data-production.tfstate"
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

data "template_cloudinit_config" "init" {
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
    content      = file("${path.module}/cloud_init/docker_install.sh")
  }

  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/cloud_init/ssm_install.sh")
  }
}
