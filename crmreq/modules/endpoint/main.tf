module "endpoints" {
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "~> 3"

  vpc_id             = var.vpc_id
  security_group_ids = var.security_group

  endpoints = {
    s3 = {
      service             = "s3"
      private_dns_enabled = false
    },
    ecr_api = {
      service             = "ecr.api"
      private_dns_enabled = false
      subnet_ids          = var.private_subnets
    },
    ecr_dkr = {
      service             = "ecr.dkr"
      private_dns_enabled = false
      subnet_ids          = var.private_subnets
    },
    logs = {
      service             = "logs"
      private_dns_enabled = false
      subnet_ids          = var.private_subnets
      
    }
  }

  tags = {
    Environment = var.env
  }
}