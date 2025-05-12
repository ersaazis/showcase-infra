output "rds_proxy_policy_arn" {
  description = "ARN of the RDS Proxy IAM Policy"
  value       = aws_iam_policy.rds_proxy_access.arn
}
