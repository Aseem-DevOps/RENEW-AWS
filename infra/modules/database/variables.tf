variable "name" { type = string } # e.g. "ml-api-db"
variable "subnet_ids" { type = list(string) } # e.g. ["subnet-12345678", "subnet-87654321"]
variable "tags" { type = map(string) } # e.g. { Environment = "dev", Project = "model-api" }
variable "identifier" { type = string } # e.g. "mlapidb"
variable "engine" { type = string } # e.g. "postgres"
variable "engine_version" { type = string } # e.g. "13.4"
variable "instance_class" { type = string } # e.g. "db.t3.medium"
variable "allocated_storage" { type = number } # e.g. 20
variable "storage_type" { type = string } # e.g. "gp2"
variable "db_name" { type = string } # e.g. "modeldb"
variable "username" { type = string } # e.g. "admin"
variable "password" { type = string } # e.g. "changeme123"
variable "vpc_security_group_ids" { type = list(string) } # e.g. ["sg-12345678"]
variable "publicly_accessible" { type = bool } # e.g. false
variable "skip_final_snapshot" { type = bool } # e.g. true
variable "backup_retention_period" { type = number } # e.g. 7
