variable "bucket_name" { type = string } # e.g. "my-ml-model-bucket"
variable "force_destroy" { type = bool } # e.g. true
variable "tags" { type = map(string) } # e.g. { Environment = "dev", Project = "model-api" }
