variable "vpc_control_plane_cidr" {
  description = "CIDR block for Control-Plane VPC"
  default     = "10.10.0.0/16"
}

variable "region" {
  description = "AWS region"
  default     = "ap-southeast-1"
}

variable "vpc_name" {
  description = "VPC name"
  default     = "vpc-control-plane"
}

variable "subnet_count" {
  description = "Number of subnets to create"
  default     = 2
}
