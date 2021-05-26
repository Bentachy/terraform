output "state_s3_bucket_arn" {
  value = aws_s3_bucket.terraform_state.arn
}

output "stage_dynamodb_table_name" {
  value = aws_dynamodb_table.terraform_locks.name
}

output "repository_url" {
  value = aws_ecr_repository.crmreq-backend-dev.repository_url
}

output "route53_main_zone_id" {
  value = values(module.route53_zone.route53_zone_zone_id)[0]
}

output "ecs_task_execution_role_name" {
  value = aws_iam_role.ecsTaskExecutionRole.name
}

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecsTaskExecutionRole.arn
}
