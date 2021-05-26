module "backend_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name                = "${var.name}-backend-${var.environment}"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["http-80-tcp","https-443-tcp","all-all"]
  
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = ["all-all"]
}

module "rds_mysql_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name                = "${var.name}-rds-${var.environment}"
  description         = "MySQL security group"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  
  ingress_with_source_security_group_id = [
    {
      rule                     = "mysql-tcp"
      source_security_group_id = "${module.backend_sg.security_group_id}"
    }
  ]

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = ["all-all"]
}

module "lb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name                = "${var.name}-lb-${var.environment}"
  vpc_id              = var.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["http-80-tcp","all-all"]
  
  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules = ["all-all"]
}