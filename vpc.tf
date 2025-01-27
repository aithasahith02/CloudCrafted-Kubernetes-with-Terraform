provider "aws"  {
    region = var.aws_region
}

data "aws_availability_zones" "available" {}

resource "random_string" "random-name" {
  length  = 6
  upper = false
  lower = true
  numeric = false
  special = false
}

locals {
  cluster_name = "sahith_Eks-${random_string.random-name.result}"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name                 = "vpc_for_sahithEKS"
  cidr                 = var.vpc_cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets       = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway   = true
  enable_ipv6 = false
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_dhcp_options = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
