resource "aws_api_gateway_rest_api" "this" {
  name        = var.name
  description = var.description
  endpoint_configuration {
    types = ["REGIONAL"]
  }
  tags = var.tags
}

resource "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = var.root_path
}

resource "aws_api_gateway_method" "root_method" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.root.id
  http_method   = var.http_method
  authorization = var.authorization
}

# API Key and Usage Plan for rate limiting
resource "aws_api_gateway_api_key" "client_key" {
  name        = "client-api-key"
  enabled     = true
  value       = var.api_key_value
}

resource "aws_api_gateway_usage_plan" "client_plan" {
  name = "client-usage-plan"
  api_stages {
    api_id = aws_api_gateway_rest_api.this.id
    stage  = aws_api_gateway_deployment.this.stage_name
  }
  throttle {
    burst_limit = var.burst_limit
    rate_limit  = var.rate_limit
  }
}

resource "aws_api_gateway_usage_plan_key" "client_key_assoc" {
  key_id        = aws_api_gateway_api_key.client_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.client_plan.id
}

resource "aws_api_gateway_deployment" "this" {
  depends_on = [aws_api_gateway_method.root_method]
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = var.stage_name
}
