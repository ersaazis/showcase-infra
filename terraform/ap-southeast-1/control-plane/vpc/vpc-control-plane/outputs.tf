output "vpc_id" {
  value = aws_vpc.control_plane.id
}

output "public_subnets" {
  value = aws_subnet.control_plane_public[*].id
}

output "vpc_cidr" {
  value = aws_vpc.control_plane.cidr_block
}

output "route_table" {
  value = aws_route_table.control_plane_route_table.id
}

output "route_table_id" {
  value = aws_route_table.control_plane_route_table.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.control_plane_internet_gateway.id
}

output "private_subnets" {
  value = aws_subnet.control_plane_private[*].id
}

output "availability_zones" {
  value = data.aws_availability_zones.available.names
}
