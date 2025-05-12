resource "aws_instance" "ec2" {
  ami                  = data.aws_ami.ubuntu_24_04_lts.id
  instance_type        = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  availability_zone    = element(data.terraform_remote_state.control_plane_vpc.outputs.availability_zones, 0)
  subnet_id            = element(data.terraform_remote_state.control_plane_vpc.outputs.private_subnets, 0)
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data            = data.template_cloudinit_config.init.rendered

  root_block_device {
    encrypted   = true
    volume_type = "gp3"
    throughput  = 125
    volume_size = 80
    tags = {
      Name      = "${var.instance_name}-root-block-device"
      Environment = "infra"
    }
  }

  tags = {
    Name        = var.instance_name
    Environment = "infra"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.instance_name}-sg"
  description = "${var.instance_name} security group"
  vpc_id      = data.terraform_remote_state.control_plane_vpc.outputs.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3022
    to_port     = 3022
    protocol    = "tcp"
    cidr_blocks = [
      data.terraform_remote_state.control_plane_vpc.outputs.vpc_cidr, 
      data.terraform_remote_state.production_vpc.outputs.vpc_cidr,
      data.terraform_remote_state.data_production_vpc.outputs.vpc_cidr,
    ]
  }

  ingress {
    from_port   = 3023
    to_port     = 3023
    protocol    = "tcp"
    cidr_blocks = [
      data.terraform_remote_state.control_plane_vpc.outputs.vpc_cidr, 
      data.terraform_remote_state.production_vpc.outputs.vpc_cidr,
      data.terraform_remote_state.data_production_vpc.outputs.vpc_cidr,
    ]
  }

  ingress {
    from_port   = 3024
    to_port     = 3024
    protocol    = "tcp"
    cidr_blocks = [
      data.terraform_remote_state.control_plane_vpc.outputs.vpc_cidr, 
      data.terraform_remote_state.production_vpc.outputs.vpc_cidr,
      data.terraform_remote_state.data_production_vpc.outputs.vpc_cidr,
    ]
  }

  ingress {
    from_port   = 3025
    to_port     = 3025
    protocol    = "tcp"
    cidr_blocks = [
      data.terraform_remote_state.control_plane_vpc.outputs.vpc_cidr, 
      data.terraform_remote_state.production_vpc.outputs.vpc_cidr,
      data.terraform_remote_state.data_production_vpc.outputs.vpc_cidr,
    ]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      data.terraform_remote_state.control_plane_vpc.outputs.vpc_cidr, 
    ]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      data.terraform_remote_state.control_plane_vpc.outputs.vpc_cidr, 
      data.terraform_remote_state.production_vpc.outputs.vpc_cidr,
      data.terraform_remote_state.data_production_vpc.outputs.vpc_cidr,
    ]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      data.terraform_remote_state.control_plane_vpc.outputs.vpc_cidr, 
      data.terraform_remote_state.production_vpc.outputs.vpc_cidr,
      data.terraform_remote_state.data_production_vpc.outputs.vpc_cidr,
    ]
  }

  tags = {
    Name        = "${var.instance_name}-sg"
    Environment = "infra"
  }
}

resource "aws_iam_role" "ec2_ssm_role" {
  name = "${var.instance_name}-ssm-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name        = "${var.instance_name}-ssm-role"
    Environment = "infra"
  }
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.instance_name}-profile"
  role = aws_iam_role.ec2_ssm_role.name
}
