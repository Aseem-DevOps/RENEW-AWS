variable "blue_name" { type = string } # e.g. "blue-tg"
variable "green_name" { type = string } # e.g. "green-tg"
variable "port" { type = number } # e.g. 80
variable "protocol" { type = string } # e.g. "HTTP"
variable "vpc_id" { type = string } # e.g. "vpc-12345678"
variable "health_check_path" { type = string } # e.g. "/health"
variable "tags" { type = map(string) } # e.g. { Environment = "dev", Project = "model-api" }
variable "listener_arn" { type = string } # e.g. "arn:aws:elasticloadbalancing:us-east-1:123456789012:listener/app/abc"
variable "blue_weight" { type = number } # e.g. 80
variable "green_weight" { type = number } # e.g. 20
