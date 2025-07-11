variable "name" { type = string } # e.g. "ml-api-cloudtrail"
variable "s3_bucket_name" { type = string } # e.g. "ml-api-cloudtrail-logs"
variable "tags" { type = map(string) } # e.g. { Environment = "dev", Project = "model-api" }
