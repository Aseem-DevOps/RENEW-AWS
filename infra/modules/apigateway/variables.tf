variable "name" { type = string } # e.g. "ml-api-gateway"
variable "description" { type = string } # e.g. "API Gateway for ML API"
variable "tags" { type = map(string) } # e.g. { Environment = "dev", Project = "model-api" }
variable "root_path" { type = string } # e.g. "/ml"
variable "http_method" { type = string } # e.g. "POST"
variable "authorization" { type = string } # e.g. "NONE"

variable "api_key_value" { type = string } # e.g. "my-api-key"
variable "burst_limit" { type = number } # e.g. 100
variable "rate_limit" { type = number } # e.g. 50
variable "stage_name" { type = string } # e.g. "prod"
