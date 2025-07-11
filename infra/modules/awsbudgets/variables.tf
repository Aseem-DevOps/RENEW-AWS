variable "name" { type = string } # e.g. "ml-api-budget"
variable "limit_amount" { type = string } # e.g. "100.00"
variable "cost_filters" { type = map(list(string)) } # e.g. { Service = ["AmazonEC2"] }
variable "threshold" { type = number } # e.g. 80
variable "subscriber_emails" { type = list(string) } # e.g. ["user@example.com"]
