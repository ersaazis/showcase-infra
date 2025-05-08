variable "vpc_data_production_cidr" {
  description = "CIDR block for Data Production VPC"
  default     = "10.30.0.0/16"
}

variable "region" {
  description = "AWS region"
  default     = "ap-southeast-1"
}

variable "vpc_name" {
  description = "VPC name"
  default     = "vpc-data-production"
}

variable "subnet_count" {
  description = "Number of subnets to create"
  default     = 2
}
