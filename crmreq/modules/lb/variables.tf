variable "vpc_id" {
  type = string
}

variable "lb_sg_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "env" {
  type = string
}

variable "project_name" {
  type = string
}
