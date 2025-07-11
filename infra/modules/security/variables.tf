variable "name" { type = string } # e.g. "ml-api-sg"
variable "description" { type = string } # e.g. "Security group for ML API"
variable "vpc_id" { type = string } # e.g. "vpc-12345678"
variable "ingress_rules" { type = list(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string), description = optional(string) })) } # e.g. [{ from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }]
variable "egress_rules" { type = list(object({ from_port = number, to_port = number, protocol = string, cidr_blocks = list(string), description = optional(string) })) } # e.g. [{ from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }]
variable "tags" { type = map(string) } # e.g. { Environment = "dev", Project = "model-api" }
