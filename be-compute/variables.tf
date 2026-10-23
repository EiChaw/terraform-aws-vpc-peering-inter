variable "region" {
  description = "The region where the resources are created."
  default     = "ap-southeast-1"
}

#############################################################
# Frontend VPC Variables
#############################################################

variable "frontend_vpc_address_space" {
  description = "The CIDR block for the frontend VPC."
  default     = "10.0.0.0/16"
}

variable "frontend_prefix" {
  description = "The prefix for the frontend resources."
  default     = "frontend"
}

variable "frontend_environment" {
  description = "The environment for the frontend resources."
  default     = "dev"
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

variable "be_instance_type" {
  description = "Specifies the AWS instance type."
  default     = "t2.micro"
}

#############################################################
# App Variables
#############################################################

variable "be_placeholder" {
  default     = "placebear.com"
  description = "Image-as-a-service URL. Some other fun ones to try are fillmurray.com, placecage.com, placebeard.it, loremflickr.com, baconmockup.com, placeimg.com, placebear.com, placeskull.com, stevensegallery.com, placedog.net"
}

variable "placeholder_id" {
  default     = "2"
  description = "Image-as-a-service URL. Some other fun ones to try are fillmurray.com, placecage.com, placebeard.it, loremflickr.com, baconmockup.com, placeimg.com, placebear.com, placeskull.com, stevensegallery.com, placedog.net"
}

variable "width" {
  default     = "600"
  description = "Image width in pixels."
}

variable "height" {
  default     = "400"
  description = "Image height in pixels."
}
