variable "profile" {
  type = string
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "password_db" {
  type        = string
  description = "Database Password"
}

variable "username_db" {
  type        = string
  description = "Login ID for the master user of DB instance"
}

variable "database_subnets" {
  type        = list(string)
  description = "IDs of database subnets"
}

variable "security_group" {
  type = list(string)
}