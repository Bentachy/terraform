variable "domain" {
  type        = string
  description = "Domain"
}

variable "frontend_bucket_domain_name" {
  type        = string
  description = "Frontent bucket domain name"
}

variable "fallback_bucket_domain_name" {
  type        = string
  description = "Fallback bucket domain name"
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "ssl_certificate_arn" {
  type        = string
  description = "SSL certificate ARN"
}
