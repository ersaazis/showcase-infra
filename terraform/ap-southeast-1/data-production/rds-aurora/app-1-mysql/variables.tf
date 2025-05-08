variable "region" {
  description = "The AWS region to launch the instance in."
  type        = string
  default     = "ap-southeast-1"
}

variable "db_name" {
  type = string
  default = "app1db"
}

variable "db_username" {
  type = string
  default = "ersa"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "db_identifier" {
  type = string
  default     = "data-production-app-one-mysql"
}
