output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.ec2.id
}

output "private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.ec2.private_ip
}

output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.ec2.public_ip
}

output "security_group_id" {
  description = "The ID of the EC2 security group"
  value       = aws_security_group.ec2_sg.id
}

output "ec2_ssm_role_name" {
  description = "IAM role for EC2 SSM"
  value       = aws_iam_role.ec2_ssm_role.name
}

output "ec2_ssm_role_arn" {
  description = "ARN from IAM role EC2 SSM"
  value       = aws_iam_role.ec2_ssm_role.arn
}

output "ec2_instance_profile_arn" {
  description = "The ARN of the EC2 Instance Profile"
  value       = aws_iam_instance_profile.ec2_instance_profile.arn
}

output "ec2_instance_profile_name" {
  description = "The name of the EC2 Instance Profile"
  value       = aws_iam_instance_profile.ec2_instance_profile.name
}
