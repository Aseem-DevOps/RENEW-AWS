variable "name" { type = string } # e.g. "ml-api-cloudwatch"
variable "retention_in_days" { type = number } # e.g. 14
variable "tags" { type = map(string) } # e.g. { Environment = "dev", Project = "model-api" }

variable "alarm_name" { type = string } # e.g. "ml-api-alarm"
variable "comparison_operator" { type = string } # e.g. "GreaterThanThreshold"
variable "evaluation_periods" { type = number } # e.g. 2
variable "metric_name" { type = string } # e.g. "CPUUtilization"
variable "namespace" { type = string } # e.g. "AWS/EC2"
variable "period" { type = number } # e.g. 300
variable "statistic" { type = string } # e.g. "Average"
variable "threshold" { type = number } # e.g. 80
variable "alarm_description" { type = string } # e.g. "Alarm when CPU exceeds 80%"
variable "actions_enabled" { type = bool } # e.g. true
variable "alarm_actions" { type = list(string) } # e.g. ["arn:aws:sns:us-east-1:123456789012:NotifyMe"]
variable "ok_actions" { type = list(string) } # e.g. ["arn:aws:sns:us-east-1:123456789012:NotifyMe"]
variable "dimensions" { type = map(string) } # e.g. { InstanceId = "i-1234567890abcdef0" }
