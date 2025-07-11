variable "filename" { type = string } # e.g. "lambda_function.zip"
variable "function_name" { type = string } # e.g. "ml-api-lambda"
variable "role_arn" { type = string } # e.g. "arn:aws:iam::123456789012:role/lambda-role"
variable "handler" { type = string } # e.g. "index.handler"
variable "runtime" { type = string } # e.g. "python3.8"
variable "memory_size" { type = number } # e.g. 256
variable "timeout" { type = number } # e.g. 30
variable "environment" { type = map(string) } # e.g. { STAGE = "dev" }
variable "tags" { type = map(string) } # e.g. { Environment = "dev", Project = "model-api" }
