resource "aws_iam_policy" "rds_proxy_access" {
  name        = "RDSProxyAccessPolicy"
  description = "Policy to allow access to RDS Proxy connection and metadata"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "RDSProxyConnect",
        Effect   = "Allow",
        Action   = "rds-db:connect",
        Resource = "arn:aws:rds-db:ap-southeast-1:${data.aws_caller_identity.current.account_id}:dbuser:${data.terraform_remote_state.rds.outputs.rds_instance_id}/*"
      },
      {
        Sid      = "RDSProxyFetchMetadata",
        Effect   = "Allow",
        Action   = [
          "rds:DescribeDBProxies",
          "rds:DescribeDBProxyEndpoints"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach the policy to EC2 IAM role
resource "aws_iam_role_policy_attachment" "rds_proxy_access_attachment" {
  role       = data.terraform_remote_state.ec2_proxy.outputs.ec2_ssm_role_name
  policy_arn = aws_iam_policy.rds_proxy_access.arn
}