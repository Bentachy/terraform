variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "terraform_state_bucket" {
  type = string
}

variable "terraform_state_lock_dynamodb_table" {
  type = string
}

variable "main_dns_zone" {
  type = string
}

variable "repository_name" {
  type        = string
  description = "Backend docker repository name"
}

variable "task_exec_role" {
  type        = string
}
