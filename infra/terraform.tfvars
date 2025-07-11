# Example values for all modules (core, optional, advanced)
vpc_cidr                = "10.0.0.0/16"
public_subnet_cidrs     = ["10.0.1.0/24", "10.0.3.0/24"]
private_subnet_cidrs    = ["10.0.2.0/24", "10.0.4.0/24"]
azs                     = ["us-east-1a", "us-east-1b"]
environment             = "dev"
project                 = "model-api"
tags                    = { Environment = "dev", Project = "model-api" }

# Database
db_name                 = "modeldb"
db_username             = "admin"
db_password             = "changeme123"
identifier              = "mlapidb"
engine                  = "postgres"
engine_version          = "13.4"
instance_class          = "db.t3.medium"
allocated_storage       = 20
storage_type            = "gp2"
vpc_security_group_ids  = ["sg-12345678"]
publicly_accessible     = false
skip_final_snapshot     = true
backup_retention_period = 7
subnet_ids              = ["subnet-12345678", "subnet-87654321"]

# Compute
ami                     = "ami-0c94855ba95c71c99"
instance_type           = "t3.medium"
subnet_id               = "subnet-12345678"
iam_instance_profile    = "ml-api-profile"
user_data               = "#!/bin/bash\necho Hello"

# Lambda
lambda_zip              = "lambda_function.zip"
lambda_role_arn         = "arn:aws:iam::123456789012:role/lambda-role"
lambda_handler          = "index.handler"
lambda_runtime          = "python3.8"
lambda_memory_size      = 256
lambda_timeout          = 30
lambda_environment      = { STAGE = "dev" }

# API Gateway
api_key_value           = "changeme-api-key"
burst_limit             = 100
rate_limit              = 50
stage_name              = "prod"
root_path               = "/ml"
http_method             = "POST"
authorization           = "NONE"

# Security Group
sg_name                 = "ml-api-sg"
sg_description          = "Security group for ML API"
sg_vpc_id               = "vpc-12345678"
ingress_rules           = [{ from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }]
egress_rules            = [{ from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }]

# S3 Storage
bucket_name             = "my-ml-model-bucket"
force_destroy           = true

# CloudTrail
cloudtrail_name         = "ml-api-cloudtrail"
cloudtrail_s3_bucket    = "ml-api-cloudtrail-logs"

# CloudWatch
cloudwatch_name         = "ml-api-cloudwatch"
retention_in_days       = 14
alarm_name              = "ml-api-alarm"
comparison_operator     = "GreaterThanThreshold"
evaluation_periods      = 2
metric_name             = "CPUUtilization"
namespace               = "AWS/EC2"
period                  = 300
statistic               = "Average"
threshold               = 80
alarm_description       = "Alarm when CPU exceeds 80%"
actions_enabled         = true
alarm_actions           = ["arn:aws:sns:us-east-1:123456789012:NotifyMe"]
ok_actions              = ["arn:aws:sns:us-east-1:123456789012:NotifyMe"]
dimensions              = { InstanceId = "i-1234567890abcdef0" }

# IAM
role_name               = "ml-api-role"
assume_role_policy      = "{...json...}"
profile_name            = "ml-api-profile"
policy_name             = "ml-api-policy"
policy                  = "{...json...}"

# ECR
ecr_name                = "ml-api-ecr"

# ALB
alb_name                = "ml-api-alb"
alb_security_group_ids  = ["sg-12345678"]
alb_subnet_ids          = ["subnet-12345678", "subnet-87654321"]
tg_name                 = "ml-api-tg"
tg_port                 = 80
tg_protocol             = "HTTP"
alb_vpc_id              = "vpc-12345678"
health_check_path       = "/health"
listener_port           = 80
listener_protocol       = "HTTP"

# Autoscaling
name_prefix             = "ml-api-asg"
max_size                = 3
min_size                = 1
desired_capacity        = 2
target_group_arns       = ["arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/abc"]

# ALB Weighted
blue_name               = "blue-tg"
green_name              = "green-tg"
port                    = 80
protocol                = "HTTP"
listener_arn            = "arn:aws:elasticloadbalancing:us-east-1:123456789012:listener/app/abc"
blue_weight             = 80
green_weight            = 20

# AWS Budgets
budget_name             = "ml-api-budget"
limit_amount            = "100.00"
cost_filters            = { Service = ["AmazonEC2"] }
budget_threshold        = 80
subscriber_emails       = ["user@example.com"]
