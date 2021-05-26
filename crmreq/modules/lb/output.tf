output "lb_arn" {
  value = module.lb.target_group_arns
}

output "domain_name" {
  value = module.lb.lb_dns_name
}
