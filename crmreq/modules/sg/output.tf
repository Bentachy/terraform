output "backend_sg_id" {
  value = module.backend_sg.security_group_id
}

output "rds_mysql_sg_id" {
  value = module.rds_mysql_sg.security_group_id
}

output "lb_sg_id" {
  value = module.lb_sg.security_group_id
}