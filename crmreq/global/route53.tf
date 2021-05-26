module "route53_zone" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2"

  zones = {
    (var.main_dns_zone) = {
      comment = var.main_dns_zone
    }
  }
}