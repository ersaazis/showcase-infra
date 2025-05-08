output "vpc_id" {
  value = aws_vpc.data_production.id
}

output "subnet_ids" {
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
