# Output VPC Peering Connection ID antara Control-Plane dan Production
output "data_production_to_production_peering_id" {
  value = aws_vpc_peering_connection.data_production_to_production.id
  description = "The ID of the VPC Peering Connection between Control-Plane and Production"
}

# Output Route Table ID di Control-Plane untuk peering ke Production
output "data_production_private_to_production_route_table_id" {
  value = aws_route.data_production_private_to_production.route_table_id
  description = "The Route Table ID in Control-Plane for the peering route to Production"
}

# Output Route Table ID di Production untuk peering ke Control-Plane
output "production_private_to_data_production_route_table_id" {
  value = aws_route.production_private_to_data_production.route_table_id
  description = "The Route Table ID in Production for the peering route to Control-Plane"
}

# Output Route Table ID di Control-Plane untuk peering ke Production
output "data_production_public_to_production_route_table_id" {
  value = aws_route.data_production_public_to_production.route_table_id
  description = "The Route Table ID in Control-Plane for the peering route to Production"
}

# Output Route Table ID di Production untuk peering ke Control-Plane
output "production_public_to_data_production_route_table_id" {
  value = aws_route.production_public_to_data_production.route_table_id
  description = "The Route Table ID in Production for the peering route to Control-Plane"
}
