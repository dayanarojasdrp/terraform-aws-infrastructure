output "bastion_security_group_id" {
  description = "Security Group ID for the bastion host."
  value       = aws_security_group.bastion.id
}

output "private_app_security_group_id" {
  description = "Security Group ID for private application servers."
  value       = aws_security_group.private_app.id
}
