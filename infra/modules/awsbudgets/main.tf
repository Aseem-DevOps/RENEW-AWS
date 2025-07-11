resource "aws_budgets_budget" "this" {
  name              = var.name
  budget_type       = "COST"
  limit_amount      = var.limit_amount
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  cost_filters      = var.cost_filters
  cost_types {
    include_tax = true
    include_subscription = true
    use_blended = false
    include_refund = false
    include_credit = false
    include_upfront = true
    include_recurring = true
    include_other_subscription = true
    include_support = true
    include_discount = true
    use_amortized = false
  }
  notification {
    comparison_operator = "GREATER_THAN"
    notification_type   = "ACTUAL"
    threshold          = var.threshold
    threshold_type     = "PERCENTAGE"
    subscriber_email_addresses = var.subscriber_emails
  }
}
