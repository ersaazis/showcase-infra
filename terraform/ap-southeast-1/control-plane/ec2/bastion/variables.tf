variable "instance_type" {
  description = "The type of instance to create."
  type        = string
  default     = "t3.medium"
}
variable "instance_name" {
  description = "The name of the EC2 instance."
  type        = string
  default     = "control-plane-bastion"
}
variable "region" {
  description = "The AWS region to launch the instance in."
  type        = string
  default     = "ap-southeast-1"
}
