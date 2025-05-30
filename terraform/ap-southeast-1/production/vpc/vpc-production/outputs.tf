output "vpc_id" {
  value = aws_vpc.production.id
}

output "public_subnets" {
  value = aws_subnet.production_public[*].id
}

output "vpc_cidr" {
  value = aws_vpc.production.cidr_block
}

output "public_route_table" {
  value = aws_route_table.production_public_route_table.id
}

output "private_route_table" {
  value = aws_route_table.production_private_route_table.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.production_internet_gateway.id
}

output "private_subnets" {
  value = aws_subnet.production_private[*].id
}

output "availability_zones" {
  value = data.aws_availability_zones.available.names
}
