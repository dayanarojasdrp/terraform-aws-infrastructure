output "vpc_id" {
  description = "ID of the VPC created for the dev environment."
  value       = module.networking.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet."
  value       = module.networking.public_subnet_id
}

output "private_subnet_id" {
  description = "ID of the private subnet."
  value       = module.networking.private_subnet_id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway."
  value       = module.networking.internet_gateway_id
}

output "bastion_security_group_id" {
  description = "Security Group ID attached to the bastion host."
  value       = module.security.bastion_security_group_id
}

output "private_app_security_group_id" {
  description = "Security Group ID attached to the private application server."
  value       = module.security.private_app_security_group_id
}

output "bastion_instance_id" {
  description = "ID of the bastion EC2 instance."
  value       = module.compute.bastion_instance_id
}

output "bastion_public_ip" {
  description = "Public IP address of the bastion host."
  value       = module.compute.bastion_public_ip
}

output "private_app_instance_id" {
  description = "ID of the private application EC2 instance."
  value       = module.compute.private_app_instance_id
}

output "private_app_private_ip" {
  description = "Private IP address of the private application server."
  value       = module.compute.private_app_private_ip
}
