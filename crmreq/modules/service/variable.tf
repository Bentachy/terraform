/*
variable "vpc_id" {
  type = string
}
*/

variable "cluster_id" {
  type = string
}

variable "container_name" {
  type = string
}

variable "container_port" {
  type = string
}

variable "name" {
  type = string
}

variable "selected_task_definition" {
  type = string
}

variable "awsvpc_subnets" {
  type = list(string)
}

variable "awsvpc_security_group_ids" {
  type = list(string)
}

variable "lb_target_group_arn" {
  type = string
}