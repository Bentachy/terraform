module "rds" {
  source = "terraform-aws-modules/rds/aws"
  version = "~> 3"

  identifier = lower("${var.profile}-${var.env}")

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine               = "mysql"
  engine_version       = "8.0.20"
  family               = "mysql8.0"
  major_engine_version = "8.0"
  instance_class       = "db.t2.micro"

  allocated_storage     = 20
  max_allocated_storage = 100
  storage_encrypted     = false

  name     = "${var.profile}_${var.env}"
  username = var.username_db
  password = var.password_db
  port     = 3306

  multi_az               = true
  subnet_ids             = var.database_subnets
  vpc_security_group_ids = var.security_group

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["error", "general", "slowquery"]

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  create_monitoring_role                = true
  monitoring_interval                   = 60

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]
}