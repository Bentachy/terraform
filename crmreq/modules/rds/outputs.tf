output "database_address" {
  value = module.rds.db_instance_address
}

output "database_port" {
  value = module.rds.db_instance_port
}

output "database_endpoint" {
  value = module.rds.db_instance_endpoint
}