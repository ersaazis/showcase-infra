# Output VPC Peering Connection ID antara Control-Plane dan Production
output "control_plane_to_data_production_peering_id" {
  value = aws_vpc_peering_connection.control_plane_to_data_production.id
  description = "The ID of the VPC Peering Connection between Control-Plane and Production"
}

# Output Route Table ID di Control-Plane untuk peering ke Production
output "control_plane_private_to_data_production_route_table_id" {
  value = aws_route.control_plane_private_to_data_production.route_table_id
  description = "The Route Table ID in Control-Plane for the peering route to Production"
}

# Output Route Table ID di Production untuk peering ke Control-Plane
output "data_production_private_to_control_plane_route_table_id" {
  value = aws_route.data_production_private_to_control_plane.route_table_id
  description = "The Route Table ID in Production for the peering route to Control-Plane"
}
# Output Route Table ID di Control-Plane untuk peering ke Production
output "control_plane_public_to_data_production_route_table_id" {
  value = aws_route.control_plane_public_to_data_production.route_table_id
  description = "The Route Table ID in Control-Plane for the peering route to Production"
}

# Output Route Table ID di Production untuk peering ke Control-Plane
output "data_production_public_to_control_plane_route_table_id" {
  value = aws_route.data_production_public_to_control_plane.route_table_id
  description = "The Route Table ID in Production for the peering route to Control-Plane"
}
