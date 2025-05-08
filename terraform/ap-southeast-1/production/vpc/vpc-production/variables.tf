variable "vpc_production_cidr" {
  description = "CIDR block for Production VPC"
  default     = "10.20.0.0/16"
}

variable "region" {
  description = "AWS region"
  default     = "ap-southeast-1"
}

variable "vpc_name" {
  description = "VPC name"
  default     = "vpc-production"
}

variable "subnet_count" {
  description = "Number of subnets to create"
  default     = 2
}
