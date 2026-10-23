variable "region" {
  description = "The region where the resources are created."
  default     = "ap-southeast-1"
}

#############################################################
# Backend VPC Variables
#############################################################

variable "backend_vpc_address_space" {
  description = "The CIDR block for the backend VPC."
  default     = "192.168.0.0/16"
}

variable "backend_prefix" {
  description = "The prefix for the backend resources."
  default     = "backend"
}

variable "backend_environment" {
  description = "The environment for the backend resources."
  default     = "dev"
}

variable "frontend_vpc_address_space" {
  description = "The CIDR block for the frontend VPC."
  default     = "10.0.0.0/16"
}