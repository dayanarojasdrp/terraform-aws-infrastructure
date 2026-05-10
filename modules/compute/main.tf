resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.bastion_security_group_id]
  associate_public_ip_address = true
  key_name                    = var.key_name
  iam_instance_profile        = var.iam_instance_profile_name

  tags = {
    Name        = "${var.project_name}-${var.environment}-bastion"
    Project     = var.project_name
    Environment = var.environment
    Role        = "bastion"
  }
}

resource "aws_instance" "private_app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.private_app_security_group_id]
  key_name               = var.key_name
  iam_instance_profile   = var.iam_instance_profile_name

  tags = {
    Name        = "${var.project_name}-${var.environment}-private-app"
    Project     = var.project_name
    Environment = var.environment
    Role        = "private-app"
  }
}
