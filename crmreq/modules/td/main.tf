data "aws_iam_policy" "cloudwatch_logs_full_access" {
  arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

module "td" {

  source           = "cn-terraform/ecs-fargate-task-definition/aws"
  version          = "~> 1"
  name_prefix      = var.name_td
  container_image  = "${var.repository_url}:${var.image_number}"
  container_name   = var.container_name
  container_memory = var.container_memory
  container_cpu    = var.container_cpu
  task_role_arn    = var.task_exec_role
  permissions_boundary = data.aws_iam_policy.cloudwatch_logs_full_access.arn

  port_mappings = [
    {
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
    }
  ]

  map_environment = {
    "PROFILE" = var.profile_app
    "PORT"    = var.port_db
    "DBUSER"  = var.username_db
    "DBNAME"  = var.db_name
    "DBPASS"  = var.password_db
    "DBURL"   = var.dburl
    "SKEY"    = var.skey
  }

  log_configuration = {
    logDriver  = "awslogs"  
    options    = {
      awslogs-group         = "awslogs-${var.name_td}"
      awslogs-region        = "eu-central-1"
      awslogs-stream-prefix = "${var.name_td}"
      awslogs-create-group  = "true"
    }
  }
}
