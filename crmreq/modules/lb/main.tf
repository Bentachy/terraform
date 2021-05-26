module "lb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6"
  name    = "${var.project_name}-${var.env}"

  tags = {
    environment = var.env
  }

  load_balancer_type = "application"

  create_lb       = true
  vpc_id          = var.vpc_id
  security_groups = [var.lb_sg_id]
  subnets         = var.subnets

  target_groups = [
    {
      name_prefix          = "api-"
      backend_protocol     = "HTTP"
      backend_port         = 8080
      target_type          = "ip"
      deregistration_delay = 5
      health_check = {
        path = "/"
        protocol = "HTTP"
        matcher = "200-299,401"
        interval = 30
        timeout = 10
        healthy_threshold = 2
        unhealthy_threshold = 2
      }
    }
  ]

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "forward"
    }
  ]
}
