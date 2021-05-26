provider "aws" {
  region  = var.aws_region
  profile = var.profile
}

provider "aws" {
  region  = "us-east-1"
  alias   = "us-east-1"
  profile = var.profile
}

// Connection to Global state
data "terraform_remote_state" "global" {
  backend = "s3"

  config = {
    bucket  = "crm-terraform-state"
    key     = "global/terraform.tfstate"
    region  = "eu-central-1"
    profile = "crm"
  }
}

module "vpc" {
  source = "../../modules/vpc"

  env  = var.env
  cidr = var.cidr
}


module "security_groups" {
  source = "../../modules/sg"

  environment = var.env
  vpc_id = module.vpc.vpc_id
  name   = var.sg_name

  depends_on = [module.vpc]
}

module "endpoints" {
  source = "../../modules/endpoint"

  env             = var.env
  vpc_id          = module.vpc.vpc_id
  security_group  = [module.security_groups.backend_sg_id]
  private_subnets = module.vpc.private_subnets

  depends_on = [module.security_groups]

}

module "s3_bucket" {
  source = "../../modules/s3"

  env      = var.env
  name     = var.domain
  writable = false

}

module "fallback_s3_bucket" {
  source = "../../modules/s3"

  writable = false
  name        = "${var.env}-${var.project_name}-fallback"
  env = var.env
}


module "ecs" {
  source = "../../modules/ecs"

  env          = var.env
  project_name = var.project_name
}

module "rds" {
  source = "../../modules/rds"

  profile          = var.profile
  env              = var.env
  username_db      = var.username_db
  password_db      = var.password_db
  database_subnets = module.vpc.database_subnets
  security_group   = [module.security_groups.rds_mysql_sg_id]

  depends_on = [module.vpc]
}

/*module "acm" {
  source = "../../modules/acm"

  route53_zone_id = data.terraform_remote_state.global.outputs.route53_main_zone_id
  domain          = var.domain
  environment     = var.env

  // We need to create certificate in region us-east-1 because oprovf CloudFront
  providers = {
    aws = aws.us-east-1
  }

  depends_on = [data.terraform_remote_state.global]
}
*/

module "lb" {
  source = "../../modules/lb"

  vpc_id       = module.vpc.vpc_id
  lb_sg_id     = module.security_groups.lb_sg_id
  subnets      = module.vpc.public_subnets
  env          = var.env
  project_name = var.project_name

}

module "td" {
  source = "../../modules/td"

  env              = var.env
  task_exec_role   = "arn:aws:iam::584537173537:role/crm-req-tasker"
  container_cpu    = var.container_cpu
  name_td          = var.name_td
  container_name   = var.repository_name
  repository_url   = data.terraform_remote_state.global.outputs.repository_url
  image_number     = var.image_number
  container_memory = var.container_memory
  dburl            = "${var.dburl1}/${module.rds.database_endpoint}:${var.port_db}/${var.profile}_${var.env}?${var.dburl2}"
  skey             = var.skey
  port_db          = var.port_db
  profile_app      = var.profile_app
  password_db      = var.password_db
  username_db      = var.username_db
  db_name          = "${var.profile}_${var.env}"

  depends_on = [module.vpc, module.ecs, module.security_groups, module.lb, data.terraform_remote_state.global]

}

resource "aws_iam_role_policy_attachment" "crmreq-s3-role-policy-attach" {
  role       = "${module.td.aws_iam_role_ecs_task_execution_role_name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  depends_on = ["module.td"]
}

resource "aws_iam_role_policy_attachment" "crmreq-ecs-role-policy-attach" {
  role       = "${module.td.aws_iam_role_ecs_task_execution_role_name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  depends_on = ["module.td"]
}

module "service" {
  source = "../../modules/service"

  cluster_id               = module.ecs.id
  container_name           = var.repository_name
  container_port           = var.container_port
  name                     = "${var.service_name}-${var.env}"
  selected_task_definition = module.td.aws_ecs_task_definition_td_family
  awsvpc_subnets            = module.vpc.private_subnets
  awsvpc_security_group_ids = [module.security_groups.backend_sg_id]
  lb_target_group_arn       = var.lb_target_group_arn

}

module "cloudfront" {
  source = "../../modules/cloudfront"

  domain                      = var.domain
  frontend_bucket_domain_name = module.s3_bucket.s3_bucket_bucket_domain_name
  ssl_certificate_arn         = "arn:aws:acm:us-east-1:584537173537:certificate/e9a7d5ed-0a07-4acb-b521-6910fb3bdf76"
  env                         = var.env

  depends_on = [data.terraform_remote_state.global]
}