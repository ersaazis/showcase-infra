resource "aws_vpc_peering_connection" "data_production_to_production" {
  vpc_id        = data.terraform_remote_state.data_production_vpc.outputs.vpc_id
  peer_vpc_id   = data.terraform_remote_state.production_vpc.outputs.vpc_id
  auto_accept   = true

  tags = {
    Name        = var.vpc_peering_name
    Environment = "infra"
  }
}

resource "aws_route" "data_production_to_production" {
  route_table_id         = data.terraform_remote_state.data_production_vpc.outputs.private_route_table
  destination_cidr_block = data.terraform_remote_state.production_vpc.outputs.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.data_production_to_production.id
}

resource "aws_route" "production_to_data_production" {
  route_table_id         = data.terraform_remote_state.production_vpc.outputs.private_route_table
  destination_cidr_block = data.terraform_remote_state.data_production_vpc.outputs.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.data_production_to_production.id
}
