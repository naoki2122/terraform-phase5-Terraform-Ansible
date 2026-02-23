data "aws_availability_zones" "available" {
  state = "available"
}

# Amazon Linux 2023 の最新AMIを自動取得
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "network" {
  source = "../../modules/network"

  project              = var.project
  vpc_cidr              = var.vpc_cidr
  azs                   = slice(data.aws_availability_zones.available.names, 0, 2)
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
}

module "iam_ssm" {
  source = "../../modules/iam_ssm"

  project = var.project
}

module "alb" {
  source = "../../modules/alb"

  project           = var.project
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
}

module "compute_asg" {
  source = "../../modules/compute_asg"

  project               = var.project
  ami_id                = data.aws_ami.al2023.id
  instance_type         = var.instance_type
  vpc_id                = module.network.vpc_id
  public_subnet_ids      = module.network.public_subnet_ids
  alb_sg_id             = module.alb.alb_sg_id
  target_group_arn      = module.alb.target_group_arn
  instance_profile_name = module.iam_ssm.instance_profile_name
}

module "rds" {
  source = "../../modules/rds"

  project            = var.project
  vpc_id             = module.network.vpc_id
  private_subnet_ids = module.network.private_subnet_ids

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  # EC2 SG からのみ 3306 を許可
  ec2_sg_id = module.compute_asg.ec2_sg_id
}