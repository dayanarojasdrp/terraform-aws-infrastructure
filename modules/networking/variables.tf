variable "project_name" {
  description = "Project name used for resource naming and tagging."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet."
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone where subnets will be created."
  type        = string
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT Gateway for private subnet outbound internet access."
  type        = bool
  default     = false
}
