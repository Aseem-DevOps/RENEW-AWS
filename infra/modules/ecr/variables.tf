variable "name" { type = string } # e.g. "ml-api-ecr"
variable "tags" { type = map(string) } # e.g. { Environment = "dev", Project = "model-api" }
