variable "name" { type = string } # e.g. "ml-api-alb"
variable "security_group_ids" { type = list(string) } # e.g. ["sg-12345678"]
variable "subnet_ids" { type = list(string) } # e.g. ["subnet-12345678", "subnet-87654321"]
variable "tags" { type = map(string) } # e.g. { Environment = "dev", Project = "model-api" }
variable "tg_name" { type = string } # e.g. "ml-api-tg"
variable "tg_port" { type = number } # e.g. 80
variable "tg_protocol" { type = string } # e.g. "HTTP"
variable "vpc_id" { type = string } # e.g. "vpc-12345678"
variable "health_check_path" { type = string } # e.g. "/health"
variable "listener_port" { type = number } # e.g. 80
variable "listener_protocol" { type = string } # e.g. "HTTP"
