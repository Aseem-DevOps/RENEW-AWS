variable "ami" { type = string } # e.g. "ami-0c94855ba95c71c99"
variable "instance_type" { type = string } # e.g. "t3.medium"
variable "subnet_id" { type = string } # e.g. "subnet-12345678"
variable "vpc_security_group_ids" { type = list(string) } # e.g. ["sg-12345678"]
variable "iam_instance_profile" { type = string } # e.g. "ml-api-profile"
variable "user_data" { type = string } # e.g. "#!/bin/bash\necho Hello"
variable "tags" { type = map(string) } # e.g. { Environment = "dev", Project = "model-api" }
