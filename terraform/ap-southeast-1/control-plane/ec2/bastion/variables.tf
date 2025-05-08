# variables.tf

variable "aws_account_name" {
   type = string
   default = "control-plane"
   description = "aws account name"
}

variable "aws_region" {
  type = string
  default = "ap-northeast-1"
  description = "aws deployment region"
}

variable "proxy_productoin_name" {
  type = string
  default = "proxy-production"
  description = "Proxy to Production instance name"
}

variable "proxy_productoin_sg_name" {
  type = string
  default = "proxy-production-security-group"
  description = "Proxy to Production security group name"
}

variable "proxy_productoin_instance_type" {
  type = string
  default = "t3.medium"
  description = "Proxy to Production instance type"
}

variable "vpc_production" {
  type = string
  default = "10.60.0.0/16"
  description = "Proxy to Production instance type"
}
