data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3"
  name    = "crmreq-${var.env}"

  cidr = var.cidr

  azs              = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  private_subnets  = [cidrsubnet(var.cidr, 8, 1), cidrsubnet(var.cidr, 8, 2)]
  public_subnets   = [cidrsubnet(var.cidr, 8, 3), cidrsubnet(var.cidr, 8, 4)]
  database_subnets = [cidrsubnet(var.cidr, 8, 5), cidrsubnet(var.cidr, 8, 6)]

  enable_ipv6                     = true
  assign_ipv6_address_on_creation = false
  map_public_ip_on_launch         = true

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = false

  enable_dns_support   = true
  enable_dns_hostnames = true
}