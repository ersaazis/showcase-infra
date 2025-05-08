output "vpc_id" {
  value = aws_vpc.production.id
}

output "subnet_ids" {
  value = aws_subnet.production_public[*].id
}

output "vpc_cidr" {
  value = aws_vpc.production.cidr_block
}

output "route_table_id" {
  value = aws_route_table.production_route_table.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.production_internet_gateway.id
}
