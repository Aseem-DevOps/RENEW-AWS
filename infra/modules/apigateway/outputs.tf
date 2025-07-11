output "rest_api_id" { value = aws_api_gateway_rest_api.this.id }
output "api_key_value" { value = aws_api_gateway_api_key.client_key.value }
output "usage_plan_id" { value = aws_api_gateway_usage_plan.client_plan.id }
