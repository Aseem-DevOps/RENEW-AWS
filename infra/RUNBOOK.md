# Operational Runbook (Basics)

## Deployment
- Edit `terraform.tfvars` for environment-specific values.
- Run `terraform init`, `terraform plan`, and `terraform apply` in the `infra` directory.
- Monitor deployment via Terraform output and AWS Console.

## Monitoring & Alerts
- CloudWatch alarms are set for CPU utilization.
- Logs are retained for 90 days.
- Review CloudTrail for audit events.

## Backups & Recovery
- RDS backups and PITR are enabled.
- S3 versioning allows model rollback.

## Security
- API keys are required for API Gateway.
- All data is encrypted at rest and in transit.
- IAM follows least privilege.

## Cost
- Review AWS Budgets and Cost Explorer for monthly spend.

## Scaling
- ASG and ALB auto-scale EC2 instances.
- Lambda scales automatically.

## A/B Testing
- Use ALB weighted target groups or API Gateway stages (add as needed).

## Blue-Green Deployments
- Use deployment pipeline (e.g., GitHub Actions) for zero-downtime updates.
