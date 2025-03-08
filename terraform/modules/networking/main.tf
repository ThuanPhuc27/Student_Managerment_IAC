module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "ecs-project"
  cidr = var.cidr_block

  azs             = var.availability_zones
  public_subnets  = var.public_subnet_ips
  private_subnets = var.private_subnet_ips

  enable_nat_gateway = true
  enable_vpn_gateway = false
  single_nat_gateway = true
  tags = {
    Name = "ecs-project"
  }
}

# Create subnet group for MongoDB
resource "aws_docdb_subnet_group" "mongodb_subnet_group" {
  subnet_ids = module.vpc.private_subnets
  name       = "mongodb-subnet-group"
}