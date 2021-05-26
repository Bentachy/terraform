module "airship-ecs-service_ecs_service" {
  source  = "blinkist/airship-ecs-service/aws//modules/ecs_service"
  version = "~> 1"

  //vpc_id         = var.vpc_id
  awsvpc_enabled                     = true
  cluster_id                         = var.cluster_id
  container_name                     = var.container_name
  container_port                     = var.container_port
  deployment_controller_type         = "ECS"
  deployment_maximum_percent         = "200"
  deployment_minimum_healthy_percent = "100"
  desired_capacity                   = "1"   // 2 default
  health_check_grace_period_seconds  = "300" // defaul 5 minutes
  launch_type                        = "FARGATE"
  load_balancing_type                = "application" // application
  name                               = var.name      // name service
  scheduling_strategy                = "REPLICA"     //replica default
  // scheduled_task_count = var.scheduled_task_count // 1 default
  selected_task_definition  = var.selected_task_definition
  with_placement_strategy   = false // false default
  assign_public_ip          = true  // true or false
  awsvpc_subnets            = var.awsvpc_subnets
  awsvpc_security_group_ids = var.awsvpc_security_group_ids
  lb_target_group_arn       = var.lb_target_group_arn
}
