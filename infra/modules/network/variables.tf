variable "vpc_cidr" { type = string } # e.g. "10.0.0.0/16"
variable "public_subnet_cidrs" { type = list(string) } # e.g. ["10.0.1.0/24", "10.0.3.0/24"]
variable "private_subnet_cidrs" { type = list(string) } # e.g. ["10.0.2.0/24", "10.0.4.0/24"]
variable "azs" { type = list(string) } # e.g. ["us-east-1a", "us-east-1b"]
variable "tags" { type = map(string) } # e.g. { Environment = "dev", Project = "model-api" }
