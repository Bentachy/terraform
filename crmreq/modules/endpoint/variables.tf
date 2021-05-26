variable "private_subnets" {
  type = list(string)
}

variable "security_group" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "env" {
  type = string
}