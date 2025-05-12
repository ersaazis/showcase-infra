resource "aws_vpc_peering_connection" "control_plane_to_production" {
  vpc_id        = data.terraform_remote_state.control_plane_vpc.outputs.vpc_id
  peer_vpc_id   = data.terraform_remote_state.production_vpc.outputs.vpc_id
  auto_accept   = true

  tags = {
    Name        = var.vpc_peering_name
    Environment = "infra"
  }
}

resource "aws_route" "control_plane_private_to_production" {
  route_table_id         = data.terraform_remote_state.control_plane_vpc.outputs.private_route_table
  destination_cidr_block = data.terraform_remote_state.production_vpc.outputs.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.control_plane_to_production.id
}
resource "aws_route" "production_private_to_control_plane" {
  route_table_id         = data.terraform_remote_state.production_vpc.outputs.private_route_table
  destination_cidr_block = data.terraform_remote_state.control_plane_vpc.outputs.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.control_plane_to_production.id
}

resource "aws_route" "control_plane_public_to_production" {
  route_table_id             = data.terraform_remote_state.control_plane_vpc.outputs.public_route_table
  destination_cidr_block     = data.terraform_remote_state.production_vpc.outputs.vpc_cidr
  vpc_peering_connection_id  = aws_vpc_peering_connection.control_plane_to_production.id
}
resource "aws_route" "production_public_to_control_plane" {
  route_table_id             = data.terraform_remote_state.production_vpc.outputs.public_route_table
  destination_cidr_block     = data.terraform_remote_state.control_plane_vpc.outputs.vpc_cidr
  vpc_peering_connection_id  = aws_vpc_peering_connection.control_plane_to_production.id
}

