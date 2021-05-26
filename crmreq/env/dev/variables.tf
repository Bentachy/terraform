variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "env" {
  type = string
}

variable "cidr" {
  type = string
}

variable "profile" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "domain" {
  type = string
}

variable "username_db" {
  type = string
}

variable "password_db" {
  type = string
}

variable "name_td" {
  type = string
}

variable "container_memory" {
  type = string
}

variable "container_cpu" {
  type = string
}

variable "skey" {
  type = string
}

variable "port_db" {
  type = string
}

variable "profile_app" {
  type = string
}

variable "dburl1" {
  type = string
}

variable "dburl2" {
  type = string
}

variable "repository_name" {
  type        = string
  description = "Backend docker repository name"
}

variable "image_number" {
  type = string
}

variable "container_port" {
  type = string
}

variable "service_name" {
  type = string
}

variable "lb_target_group_arn" {
  type = string
}