variable "project_name" {
  description = "Project name used for resource naming and tagging."
  type        = string
}

variable "environment" {
  description = "Environment where IAM resources will be created."
  type        = string
}
