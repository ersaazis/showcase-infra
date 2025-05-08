variable "region" {
  description = "AWS region"
  default     = "ap-southeast-1"
}

variable "vpc_peering_name" {
  description = "Name tag for the VPC Peering connection"
  default     = "vpc-peering-production-data-production"
}
