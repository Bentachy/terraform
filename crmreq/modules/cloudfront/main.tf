module "cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "2.4.0"

  aliases = [var.domain]

  price_class                   = "PriceClass_All"
  enabled                       = true
  is_ipv6_enabled               = true
  default_root_object           = "index.html"
  create_origin_access_identity = true
  origin_access_identities = {
    bucket_frontend = "Frontend S3 bucket"
  }

  origin = {
    "frontend_${var.env}" = {
      domain_name = var.frontend_bucket_domain_name

      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }
  }

  default_cache_behavior = {
    path_pattern           = "/*"
    target_origin_id       = "frontend_${var.env}"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

  // Certificate from us-west-1
  viewer_certificate = {
    acm_certificate_arn = var.ssl_certificate_arn
    ssl_support_method  = "sni-only"
  }

  custom_error_response = [
    {
      error_code            = 403
      response_code         = 200
      response_page_path    = "/index.html"
      error_caching_min_ttl = 10
    }
  ]
}
