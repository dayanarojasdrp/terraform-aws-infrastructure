output "bastion_instance_id" {
  description = "ID of the bastion EC2 instance."
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "Public IP address of the bastion host."
  value       = aws_instance.bastion.public_ip
}

output "private_app_instance_id" {
  description = "ID of the private application EC2 instance."
  value       = aws_instance.private_app.id
}

output "private_app_private_ip" {
  description = "Private IP address of the private application server."
  value       = aws_instance.private_app.private_ip
}
