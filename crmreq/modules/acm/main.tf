terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3"
      configuration_aliases = [ aws ]
    }
  }
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 3"

  domain_name  = var.domain
  zone_id      = var.route53_zone_id
  wait_for_validation = false

  tags = {
    environment = var.environment
    
  }
}