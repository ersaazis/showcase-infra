output "vpc_id" {
  value = aws_vpc.data_production.id
}

output "public_subnets" {
  value = aws_subnet.data_production_public[*].id
}

output "vpc_cidr" {
  value = aws_vpc.data_production.cidr_block
}

output "route_table_id" {
  value = aws_route_table.data_production_route_table.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.data_production_internet_gateway.id
}

output "private_subnets" {
  value = aws_subnet.data_production_private[*].id
}

output "availability_zones" {
  value = data.aws_availability_zones.available.names
}