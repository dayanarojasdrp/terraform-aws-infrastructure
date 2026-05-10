aws_region = "us-east-1"

project_name = "terraform-aws-infrastructure"
environment  = "dev"

vpc_cidr            = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
availability_zone   = "us-east-1a"

instance_type = "t2.micro"

allowed_ssh_cidr = "0.0.0.0/0"

ami_id = "ami-0a59ec92177ec3fad"
key_name = "KEY_PAIR_REAL_AQUI"

enable_nat_gateway = false
