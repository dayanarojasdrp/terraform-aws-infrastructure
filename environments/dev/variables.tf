variable "aws_region" {
  description = "AWS region where the infrastructure will be deployed."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for tagging AWS resources."
  type        = string
  default     = "terraform-aws-infrastructure"
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the main VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet."
  type        = string
  default     = "10.0.2.0/24"
}

variable "availability_zone" {
  description = "Availability Zone used for the lab subnets."
  type        = string
  default     = "us-east-1a"
}

variable "instance_type" {
  description = "EC2 instance type used for Free Tier-compatible lab instances."
  type        = string
  default     = "t2.micro"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into the bastion host."
  type        = string
  default     = "0.0.0.0/0"
}

variable "ami_id" {
  description = "AMI ID used for EC2 instances."
  type        = string
  default     = ""
}

variable "key_name" {
  description = "Existing AWS key pair name used to SSH into EC2 instances."
  type        = string
  default     = ""
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT Gateway for private subnet outbound internet access."
  type        = bool
  default     = false
}
