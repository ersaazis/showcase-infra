# main.tf

module "proxy_production" {
  source = "git@github.com:bitwyre/infra-code.git//terraform-modules/terraform-aws-ec2-instance?ref=terraform-aws-ec2/v0.0.1"

  name                   = var.proxy_productoin_name
  ami                    = data.aws_ami.ubuntu_24_04_lts.id
  instance_type          = var.proxy_productoin_instance_type
  iam_instance_profile   = data.terraform_remote_state.iam_ec2_ssm_encrypted_session.outputs.ssm_role_name
  availability_zone      = element(data.terraform_remote_state.vpc_control_plane_production.outputs.availability_zones, 0)
  subnet_id              = element(data.terraform_remote_state.vpc_control_plane_production.outputs.private_subnets, 0)
  vpc_security_group_ids = [module.proxy_production_sg.security_group_id]
  user_data              = data.template_cloudinit_config.proxy_production_init.rendered

  enable_volume_tags = false

  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 125
      volume_size = 100
      tags = {
        Name         = "proxy-production-root-block-device"
        Terraform    = "true"
        Snapshot     = "true"
        Context      = "Proxy to Production Root Block Device"
        Scope        = "Infrastructure"
        Account_Name = "control-plane"
        Account_ID   = data.aws_caller_identity.current.account_id
      }
    },
  ]

  tags = {
    Name         = var.proxy_productoin_name
    Terraform    = "true"
    Context      = "Proxy Production Control Plane Infra Tools"
    Scope        = "Infrastructure"
    Account_Name = "control-plane"
    Account_ID   = data.aws_caller_identity.current.account_id
  }
}

module "proxy_production_sg" {
  source = "git@github.com:bitwyre/infra-code.git//terraform-modules/terraform-aws-security-group?ref=terraform-aws-security-module/v0.0.1"

  name        = var.proxy_productoin_sg_name
  description = "Proxy to Production vpc security group"
  vpc_id      = data.terraform_remote_state.vpc_control_plane_production.outputs.vpc_id

  egress_rules = [
    "all-all"
  ]

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = data.terraform_remote_state.vpc_control_plane_production.outputs.vpc_cidr_block
    },
    {
      from_port   = 3128
      to_port     = 3128
      protocol    = "tcp"
      cidr_blocks = data.terraform_remote_state.vpc_control_plane_production.outputs.vpc_cidr_block
    },
    {
      from_port   = 3128
      to_port     = 3128
      protocol    = "tcp"
      cidr_blocks = var.vpc_production
    }
  ]

  tags = {
    Name         = var.proxy_productoin_sg_name
    Terraform    = "true"
    Context      = "Proxy to Production Security Group"
    Scope        = "Infrastructure"
    Account_Name = "control-plane"
    Account_ID   = data.aws_caller_identity.current.account_id
  }
}
