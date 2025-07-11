# Example remote backend configuration for state management
# Uncomment and configure as needed
# terraform {
#   backend "s3" {
#     bucket         = "my-tf-state-bucket"
#     key            = "model-api/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "my-tf-lock-table"
#     encrypt        = true
#   }
# }
