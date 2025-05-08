output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.mysql.endpoint
}

output "rds_instance_id" {
  description = "The RDS instance identifier"
  value       = aws_db_instance.mysql.id
}

output "rds_security_group_id" {
  description = "The security group ID associated with RDS"
  value       = aws_security_group.rds_sg.id
}

output "rds_subnet_group" {
  description = "The subnet group name used by RDS"
  value       = aws_db_subnet_group.mysql.name
}
