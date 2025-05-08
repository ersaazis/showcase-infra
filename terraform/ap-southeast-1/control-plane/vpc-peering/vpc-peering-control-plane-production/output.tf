# Output VPC Peering Connection ID antara Control-Plane dan Production
output "control_plane_to_production_peering_id" {
  value = aws_vpc_peering_connection.control_plane_to_production.id
  description = "The ID of the VPC Peering Connection between Control-Plane and Production"
}

# Output Route Table ID di Control-Plane untuk peering ke Production
output "control_plane_to_production_route_table_id" {
  value = aws_route.control_plane_to_production.route_table_id
  description = "The Route Table ID in Control-Plane for the peering route to Production"
}

# Output Route Table ID di Production untuk peering ke Control-Plane
output "production_to_control_plane_route_table_id" {
  value = aws_route.production_to_control_plane.route_table_id
  description = "The Route Table ID in Production for the peering route to Control-Plane"
}
