locals {
  name        = "${var.project_name}-${local.environment}"
  environment = var.env
}

data "aws_availability_zones" "available" {
  state = "available"
}

module "ecs" {
  source = "terraform-aws-modules/ecs/aws"
  version = "~> 3"

  name = local.name

  container_insights = true

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy = [
    {
      capacity_provider = "FARGATE"
      weight            = "1"
    }
  ]

  tags = {
    Environment = local.environment
  }
}