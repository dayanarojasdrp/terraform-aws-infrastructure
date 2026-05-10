variable "project_name" {
  description = "Project name used for resource naming and tagging."
  type        = string
}

variable "environment" {
  description = "Environment where the compute resources will be deployed."
  type        = string
}

variable "ami_id" {
  description = "AMI ID used to launch the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type used for the bastion and private app server."
  type        = string
}

variable "key_name" {
  description = "Existing AWS key pair name used for SSH access."
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID where the bastion host will be deployed."
  type        = string
}

variable "private_subnet_id" {
  description = "Private subnet ID where the private app server will be deployed."
  type        = string
}

variable "bastion_security_group_id" {
  description = "Security Group ID attached to the bastion host."
  type        = string
}

variable "private_app_security_group_id" {
  description = "Security Group ID attached to the private app server."
  type        = string
}
