variable "name_prefix" { type = string } # e.g. "ml-api-asg"
variable "ami" { type = string } # e.g. "ami-0c94855ba95c71c99"
variable "instance_type" { type = string } # e.g. "t3.medium"
variable "user_data" { type = string } # e.g. "#!/bin/bash\necho Hello"
variable "iam_instance_profile" { type = string } # e.g. "ml-api-profile"
variable "security_group_ids" { type = list(string) } # e.g. ["sg-12345678"]
variable "tags" { type = map(string) } # e.g. { Environment = "dev", Project = "model-api" }
variable "name" { type = string } # e.g. "ml-api-asg"
variable "max_size" { type = number } # e.g. 3
variable "min_size" { type = number } # e.g. 1
variable "desired_capacity" { type = number } # e.g. 2
variable "subnet_ids" { type = list(string) } # e.g. ["subnet-12345678", "subnet-87654321"]
variable "target_group_arns" { type = list(string) } # e.g. ["arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/abc"]
