output "aws_ecs_task_definition_td_arn" {
  description = "Full ARN of the Task Definition (including both family and revision)."
  value       = module.td.aws_ecs_task_definition_td_arn
}

output "aws_ecs_task_definition_td_family" {
  description = "The family of the Task Definition."
  value       = module.td.aws_ecs_task_definition_td_family
}

output "aws_ecs_task_definition_td_revision" {
  description = "The revision of the task in a particular family."
  value       = module.td.aws_ecs_task_definition_td_revision
}


output "aws_iam_role_ecs_task_execution_role_name" {
  description = "The name of the role."
  value       = module.td.aws_iam_role_ecs_task_execution_role_name
}