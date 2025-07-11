
variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16" # e.g. "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs (multi-AZ)."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.3.0/24"] # e.g. ["10.0.1.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs (multi-AZ)."
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.4.0/24"] # e.g. ["10.0.2.0/24", "10.0.4.0/24"]
}

variable "azs" {
  description = "List of availability zones."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"] # e.g. ["us-east-1a", "us-east-1b"]
}

variable "environment" {
  description = "Deployment environment."
  type        = string
  default     = "dev" # e.g. "dev"
}

variable "project" {
  description = "Project name."
  type        = string
  default     = "model-api" # e.g. "model-api"
}

variable "db_name" {
  description = "Database name."
  type        = string
  default     = "modeldb" # e.g. "modeldb"
}

variable "db_username" {
  description = "Database username."
  type        = string
  default     = "admin" # e.g. "admin"
}

variable "db_password" {
  description = "Database password."
  type        = string
  sensitive   = true # e.g. "changeme123"
}

variable "ami" {
  description = "AMI ID for EC2 instance."
  type        = string
  default     = "ami-0c94855ba95c71c99" # e.g. "ami-0c94855ba95c71c99"
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
}

variable "user_data" {
  description = "User data script for EC2 instance."
  type        = string
  default     = "#!/bin/bash\nyum update -y\nyum install -y python3 python3-pip\n# Start API server (placeholder)\n# python3 /app/server.py\n"
}

variable "lambda_zip" {
  description = "Path to Lambda deployment package zip file."
  type        = string
  default     = "lambda_function.zip"
}

variable "lambda_role_arn" {
  description = "IAM role ARN for Lambda function."
  type        = string
  default     = ""
}

variable "lambda_handler" {
  description = "Lambda handler."
  type        = string
  default     = "index.handler"
}

variable "lambda_runtime" {
  description = "Lambda runtime."
  type        = string
  default     = "python3.9"
}
variable "api_key_value" {
  description = "API key value for API Gateway."
  type        = string
  default     = "changeme-api-key"
}

variable "burst_limit" {
  description = "API Gateway burst limit."
  type        = number
  default     = 100
}

variable "rate_limit" {
  description = "API Gateway rate limit (req/sec)."
  type        = number
  default     = 50
}

  description = "API Gateway stage name."
  type        = string
  default     = "prod"
variable "stage_name" {
  description = "API Gateway stage name."
  type        = string
  default     = "prod"
}

# --- Additional variables for full compatibility with terraform.tfvars ---
variable "tags" {
  description = "Common tags for all resources."
  type        = map(string)
  default     = { Environment = "dev", Project = "model-api" }
}
variable "identifier" { description = "Database identifier." type = string default = "mlapidb" }
variable "engine" { description = "Database engine." type = string default = "postgres" }
variable "engine_version" { description = "Database engine version." type = string default = "13.4" }
variable "instance_class" { description = "Database instance class." type = string default = "db.t3.medium" }
variable "allocated_storage" { description = "Database allocated storage (GB)." type = number default = 20 }
variable "storage_type" { description = "Database storage type." type = string default = "gp2" }
variable "vpc_security_group_ids" { description = "List of VPC security group IDs." type = list(string) default = ["sg-12345678"] }
variable "publicly_accessible" { description = "Whether the DB is publicly accessible." type = bool default = false }
variable "skip_final_snapshot" { description = "Skip final DB snapshot on destroy." type = bool default = true }
variable "backup_retention_period" { description = "DB backup retention period (days)." type = number default = 7 }
variable "subnet_ids" { description = "List of subnet IDs." type = list(string) default = ["subnet-12345678", "subnet-87654321"] }
variable "subnet_id" { description = "Subnet ID." type = string default = "subnet-12345678" }
variable "iam_instance_profile" { description = "IAM instance profile name." type = string default = "ml-api-profile" }
variable "lambda_memory_size" { description = "Lambda memory size (MB)." type = number default = 256 }
variable "lambda_timeout" { description = "Lambda timeout (seconds)." type = number default = 30 }
variable "lambda_environment" { description = "Lambda environment variables." type = map(string) default = { STAGE = "dev" } }
variable "root_path" { description = "API Gateway root path." type = string default = "/ml" }
variable "http_method" { description = "API Gateway HTTP method." type = string default = "POST" }
variable "authorization" { description = "API Gateway authorization type." type = string default = "NONE" }
variable "sg_name" { description = "Security group name." type = string default = "ml-api-sg" }
variable "sg_description" { description = "Security group description." type = string default = "Security group for ML API" }
variable "sg_vpc_id" { description = "Security group VPC ID." type = string default = "vpc-12345678" }
variable "ingress_rules" { description = "Security group ingress rules." type = list(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string), description = optional(string) })) default = [{ from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }] }
variable "egress_rules" { description = "Security group egress rules." type = list(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string), description = optional(string) })) default = [{ from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }] }
variable "bucket_name" { description = "S3 bucket name." type = string default = "my-ml-model-bucket" }
variable "force_destroy" { description = "Force destroy S3 bucket." type = bool default = true }
variable "cloudtrail_name" { description = "CloudTrail name." type = string default = "ml-api-cloudtrail" }
variable "cloudtrail_s3_bucket" { description = "CloudTrail S3 bucket name." type = string default = "ml-api-cloudtrail-logs" }
variable "cloudwatch_name" { description = "CloudWatch log group name." type = string default = "ml-api-cloudwatch" }
variable "retention_in_days" { description = "CloudWatch log retention (days)." type = number default = 14 }
variable "alarm_name" { description = "CloudWatch alarm name." type = string default = "ml-api-alarm" }
variable "comparison_operator" { description = "CloudWatch alarm comparison operator." type = string default = "GreaterThanThreshold" }
variable "evaluation_periods" { description = "CloudWatch alarm evaluation periods." type = number default = 2 }
variable "metric_name" { description = "CloudWatch alarm metric name." type = string default = "CPUUtilization" }
variable "namespace" { description = "CloudWatch alarm namespace." type = string default = "AWS/EC2" }
variable "period" { description = "CloudWatch alarm period (seconds)." type = number default = 300 }
variable "statistic" { description = "CloudWatch alarm statistic." type = string default = "Average" }
variable "threshold" { description = "CloudWatch alarm threshold." type = number default = 80 }
variable "alarm_description" { description = "CloudWatch alarm description." type = string default = "Alarm when CPU exceeds 80%" }
variable "actions_enabled" { description = "CloudWatch alarm actions enabled." type = bool default = true }
variable "alarm_actions" { description = "CloudWatch alarm actions." type = list(string) default = ["arn:aws:sns:us-east-1:123456789012:NotifyMe"] }
variable "ok_actions" { description = "CloudWatch alarm OK actions." type = list(string) default = ["arn:aws:sns:us-east-1:123456789012:NotifyMe"] }
variable "dimensions" { description = "CloudWatch alarm dimensions." type = map(string) default = { InstanceId = "i-1234567890abcdef0" } }
variable "role_name" { description = "IAM role name." type = string default = "ml-api-role" }
variable "assume_role_policy" { description = "IAM assume role policy JSON." type = string default = "{...json...}" }
variable "profile_name" { description = "IAM profile name." type = string default = "ml-api-profile" }
variable "policy_name" { description = "IAM policy name." type = string default = "ml-api-policy" }
variable "policy" { description = "IAM policy JSON." type = string default = "{...json...}" }
variable "ecr_name" { description = "ECR repository name." type = string default = "ml-api-ecr" }
variable "alb_name" { description = "ALB name." type = string default = "ml-api-alb" }
variable "alb_security_group_ids" { description = "ALB security group IDs." type = list(string) default = ["sg-12345678"] }
variable "alb_subnet_ids" { description = "ALB subnet IDs." type = list(string) default = ["subnet-12345678", "subnet-87654321"] }
variable "tg_name" { description = "Target group name." type = string default = "ml-api-tg" }
variable "tg_port" { description = "Target group port." type = number default = 80 }
variable "tg_protocol" { description = "Target group protocol." type = string default = "HTTP" }
variable "alb_vpc_id" { description = "ALB VPC ID." type = string default = "vpc-12345678" }
variable "health_check_path" { description = "ALB health check path." type = string default = "/health" }
variable "listener_port" { description = "ALB listener port." type = number default = 80 }
variable "listener_protocol" { description = "ALB listener protocol." type = string default = "HTTP" }
variable "name_prefix" { description = "Autoscaling group name prefix." type = string default = "ml-api-asg" }
variable "max_size" { description = "Autoscaling group max size." type = number default = 3 }
variable "min_size" { description = "Autoscaling group min size." type = number default = 1 }
variable "desired_capacity" { description = "Autoscaling group desired capacity." type = number default = 2 }
variable "target_group_arns" { description = "Autoscaling group target group ARNs." type = list(string) default = ["arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/abc"] }
variable "blue_name" { description = "ALB weighted blue target group name." type = string default = "blue-tg" }
variable "green_name" { description = "ALB weighted green target group name." type = string default = "green-tg" }
variable "port" { description = "ALB weighted port." type = number default = 80 }
variable "protocol" { description = "ALB weighted protocol." type = string default = "HTTP" }
variable "listener_arn" { description = "ALB weighted listener ARN." type = string default = "arn:aws:elasticloadbalancing:us-east-1:123456789012:listener/app/abc" }
variable "blue_weight" { description = "ALB weighted blue weight." type = number default = 80 }
variable "green_weight" { description = "ALB weighted green weight." type = number default = 20 }
variable "budget_name" { description = "AWS Budget name." type = string default = "ml-api-budget" }
variable "limit_amount" { description = "AWS Budget limit amount." type = string default = "100.00" }
variable "cost_filters" { description = "AWS Budget cost filters." type = map(list(string)) default = { Service = ["AmazonEC2"] } }
variable "budget_threshold" { description = "AWS Budget threshold." type = number default = 80 }
variable "subscriber_emails" { description = "AWS Budget subscriber emails." type = list(string) default = ["user@example.com"] }
}
