module "networking" {
  source = "../../modules/networking"

  project_name        = var.project_name
  environment         = var.environment
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zone   = var.availability_zone
  enable_nat_gateway  = var.enable_nat_gateway
}
module "security" {
  source = "../../modules/security"

  project_name     = var.project_name
  environment      = var.environment
  vpc_id           = module.networking.vpc_id
  allowed_ssh_cidr = var.allowed_ssh_cidr
}
module "compute" {
  source = "../../modules/compute"

  project_name                  = var.project_name
  environment                   = var.environment
  ami_id                        = var.ami_id
  instance_type                 = var.instance_type
  key_name                      = var.key_name
  public_subnet_id              = module.networking.public_subnet_id
  private_subnet_id             = module.networking.private_subnet_id
  bastion_security_group_id     = module.security.bastion_security_group_id
  private_app_security_group_id = module.security.private_app_security_group_id
  iam_instance_profile_name     = module.iam.ec2_instance_profile_name
}
module "iam" {
  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment
}
