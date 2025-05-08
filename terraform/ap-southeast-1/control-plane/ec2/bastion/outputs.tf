# outputs.tf

output "ec2_proxy_production_id" {
  value       = module.proxy_production.id
  description = "Proxy Production Control Plane Infra Tools EC2 ID"
}

output "ec2_proxy_production_public_arn" {
  value       = module.proxy_production.arn
  description = "Proxy Production Control Plane Infra Tools EC2 ARN"
}

output "ec2_proxy_production_instance_state" {
  value       = module.proxy_production.instance_state
  description = "Proxy Production Control Plane Infra Tools EC2 Instance State"
}

output "ec2_proxy_production_primary_interface_id" {
  value       = module.proxy_production.primary_network_interface_id
  description = "Proxy Production Control Plane Infra Tools EC2 Primary Interface ID"
}

output "ec2_proxy_production_private_ip" {
  value       = module.proxy_production.private_ip
  description = "Proxy Production Control Plane Infra Tools EC2 Private IP"
}

output "ec2_proxy_production_private_dns" {
  description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = module.proxy_production.private_dns
}

output "ec2_proxy_production_tags" {
  value       = module.proxy_production.tags_all
  description = "Proxy Production Control Plane Infra Tools EC2 Tags"
}


output "ec2_proxy_production_root_block_device" {
  description = "Root block device information"
  value       = module.proxy_production.root_block_device
}

output "ec2_proxy_production_ebs_block_device" {
  description = "EBS block device information"
  value       = module.proxy_production.ebs_block_device
}

output "ec2_proxy_production_iam_instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile"
  value       = module.proxy_production.iam_instance_profile_arn
}

output "ec2_proxy_production_iam_instance_profile_id" {
  description = "Instance profile's ID"
  value       = module.proxy_production.iam_instance_profile_id
}

output "ec2_proxy_production_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.proxy_production.iam_role_name
}

output "ec2_proxy_production_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.proxy_production.iam_role_arn
}
