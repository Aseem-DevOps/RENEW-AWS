

# Multi-AZ Networking
module "network" {
  source               = "./modules/network"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
  tags = {
    Environment = var.environment
    Project     = var.project
  }
}

# Security Group
module "security" {
  source      = "./modules/security"
  name        = "model-api-sg"
  description = "Security group for model API"
  vpc_id      = module.network.vpc_id
  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTPS"
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  tags = {
    Environment = var.environment
    Project     = var.project
  }
}

# S3 Storage
module "storage" {
  source        = "./modules/storage"
  bucket_name   = "${var.project}-ml-bucket"
  force_destroy = true
  tags = {
    Environment = var.environment
    Project     = var.project
  }
}

# IAM
module "iam" {
  source             = "./modules/iam"
  role_name          = "model-api-ec2-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
  profile_name = "model-api-ec2-profile"
  policy_name  = "model-api-ec2-policy"
  policy       = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = ["s3:GetObject", "s3:PutObject"]
      Resource = ["*"]
    }]
  })
}

# Database
module "database" {
  source                  = "./modules/database"
  name                    = "model-db-subnet-group"
  subnet_ids              = module.network.private_subnet_ids
  tags                    = { Environment = var.environment, Project = var.project }
  identifier              = "model-api-db"
  engine                  = "postgres"
  engine_version          = "12.5"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  storage_type            = "gp2"
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  vpc_security_group_ids  = [module.security.security_group_id]
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 7
}

# Application Load Balancer
module "alb" {
  source              = "./modules/alb"
  name                = "model-api-alb"
  security_group_ids  = [module.security.security_group_id]
  subnet_ids          = module.network.public_subnet_ids
  tags                = { Environment = var.environment, Project = var.project }
  tg_name             = "model-api-tg"
  tg_port             = 80
  tg_protocol         = "HTTP"
  vpc_id              = module.network.vpc_id
  health_check_path   = "/health"
  listener_port       = 80
  listener_protocol   = "HTTP"
}

# Auto Scaling Group
module "autoscaling" {
  source                = "./modules/autoscaling"
  name_prefix           = "model-api-asg-"
  ami                   = var.ami
  instance_type         = var.instance_type
  user_data             = var.user_data
  iam_instance_profile  = module.iam.instance_profile_name
  security_group_ids    = [module.security.security_group_id]
  tags                  = { Environment = var.environment, Project = var.project }
  name                  = "model-api-asg"
  max_size              = 4
  min_size              = 2
  desired_capacity      = 2
  subnet_ids            = module.network.public_subnet_ids
  target_group_arns     = [module.alb.target_group_arn]
}

# API Gateway
module "apigateway" {
  source        = "./modules/apigateway"
  name          = "model-api"
  description   = "Model serving API"
  tags          = { Environment = var.environment, Project = var.project }
  root_path     = "predict"
  http_method   = "POST"
  authorization = "NONE"
  api_key_value = var.api_key_value
  burst_limit   = var.burst_limit
  rate_limit    = var.rate_limit
  stage_name    = var.stage_name
}

# Lambda for Inference
module "lambda" {
  source        = "./modules/lambda"
  filename      = var.lambda_zip
  function_name = "model-inference"
  role_arn      = var.lambda_role_arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  memory_size   = 512
  timeout       = 30
  environment   = {
    MODEL_BUCKET = module.storage.bucket_name
  }
  tags          = { Environment = var.environment, Project = var.project }
}

# CloudTrail for Audit Logging
module "cloudtrail" {
  source         = "./modules/cloudtrail"
  name           = "model-api-cloudtrail"
  s3_bucket_name = module.storage.bucket_name
  tags           = { Environment = var.environment, Project = var.project }
}

  source             = "./modules/cloudwatch"
  name               = "/aws/model-api"
  retention_in_days  = 90
  tags               = { Environment = var.environment, Project = var.project }
  alarm_name         = "model-api-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = 2
  metric_name        = "CPUUtilization"
  namespace          = "AWS/EC2"
  period             = 300
  statistic          = "Average"
  threshold          = 80
  alarm_description  = "Alarm if CPU > 80% for 10 minutes"
  actions_enabled    = true
  alarm_actions      = []
  ok_actions         = []
  dimensions         = {}

}

# ECR Repository
module "ecr" {
  source   = "./modules/ecr"
  name     = var.ecr_name
  tags     = var.tags
}

# ALB Weighted Routing
module "alb_weighted" {
  source        = "./modules/alb_weighted"
  blue_name     = var.blue_name
  green_name    = var.green_name
  port          = var.port
  protocol      = var.protocol
  vpc_id        = var.alb_vpc_id
  health_check_path = var.health_check_path
  tags          = var.tags
  listener_arn  = var.listener_arn
  blue_weight   = var.blue_weight
  green_weight  = var.green_weight
}

# AWS Budgets
module "awsbudgets" {
  source            = "./modules/awsbudgets"
  name              = var.budget_name
  limit_amount      = var.limit_amount
  cost_filters      = var.cost_filters
  threshold         = var.budget_threshold
  subscriber_emails = var.subscriber_emails
}
