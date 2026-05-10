output "ec2_instance_profile_name" {
  description = "IAM instance profile name attached to EC2 instances."
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "ec2_role_name" {
  description = "IAM role name used by EC2 instances."
  value       = aws_iam_role.ec2_role.name
}
