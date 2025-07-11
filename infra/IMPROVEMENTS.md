# Improvements, Assumptions, and Recommendations

## Identified Issues & Fixes
- Security: Hardened security groups, encryption at rest/in transit, least privilege IAM, API key auth, CloudTrail.
- Reliability: Multi-AZ, ALB, ASG, health checks, private RDS, backups.
- Best Practices: Modular code, variables, outputs, tagging, environment separation.
- Operational: CloudWatch monitoring, log retention, audit logging, cost-conscious defaults.
- API: API Gateway with key/rate limiting, Lambda for inference.

## Assumptions
- Lambda and API Gateway are used for inference and API management.
- Blue-green deployments and A/B testing are handled by CI/CD or deployment pipeline.
- ECS/ECR is optional and can be enabled for container-based workloads.
- Cost estimation is based on AWS pricing for selected instance types and services.



## Optional Features Now Available & Fully Integrated
- **ECS/ECR modules** for container-based deployment are included and can be enabled at any time.
- **ALB weighted routing module** is available and now fully referenced in the root configuration for A/B testing and blue-green deployments.
- **AWS Budgets module** is available and now fully referenced in the root configuration for cost monitoring and alerting.



---


- All required and optional modules (ECS, ECR, AWS Budgets, ALB weighted routing, etc.) are now referenced and configured in the root Terraform configuration.
- All variables in `terraform.tfvars` are declared in `variables.tf` and passed to the relevant modules, ensuring full compatibility and extensibility.
- No inconsistencies or missing references remain between modules, variables, and root configuration.

You can enable or configure any module as needed for your use case by updating the corresponding variables in `terraform.tfvars`.

---

## Cost Estimation (Typical Usage)

| Resource                | Example Size/Type         | Monthly Estimate (USD) |
|-------------------------|---------------------------|------------------------|
| VPC, Subnets, SGs       | n/a                       | $0                     |
| EC2 (2x t3.medium, ASG) | 2x t3.medium, 730 hrs     | ~$50                   |
| RDS PostgreSQL          | db.t3.medium, 100GB       | ~$120                  |
| S3 (model storage)      | 500GB, versioned          | ~$12                   |
| ALB                     | 1x                        | ~$20                   |
| Lambda                  | 1M req, 256MB, 1s avg     | ~$5                    |
| API Gateway             | 1M req                    | ~$3                    |
| CloudWatch/CloudTrail   | Logs, metrics, audit      | ~$10                   |
| ECR/ECS (optional)      | 1 repo, 1 cluster         | ~$10                   |
| AWS Budgets             | 1 budget                  | $0                     |
| Data Transfer           | 1TB out                   | ~$90                   |
| **Total (est.)**        |                           | **~$320/mo**           |

*Actual costs will vary by usage, region, and enabled features. Use the AWS Pricing Calculator for precise estimates.*

---

## Additional Notes

- **Batch Prediction:** Batch size limits (e.g., 100 items/request) are enforced in application code or API Gateway mapping templates, not at the infrastructure level. Document this in your API implementation.
- **CloudWatch Log Retention:** Default is set to 14 or 90 days as required; update `retention_in_days` in `terraform.tfvars` for compliance.
- **S3 Model Versioning:** S3 bucket versioning is enabled by default in the storage module.
- **RDS Backups:** RDS backup retention and skip final snapshot are set via variables and default to best practices.
- **State Management:** See `backend.tf` for a remote backend example (S3 + DynamoDB). Uncomment and configure as needed.
- **Environment Separation:** Use Terraform workspaces or separate state files for dev/prod environments. Document this in your team runbook.

---

---
