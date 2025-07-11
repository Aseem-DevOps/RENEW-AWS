
# Architecture Diagram

```
+-------------------+         +-------------------+         +-------------------+
|   API Gateway     | <-----> |   Lambda (ML)     | <-----> |     S3 Bucket     |
+-------------------+         +-------------------+         +-------------------+
        |                                                        |
        v                                                        v
+-------------------+         +-------------------+         +-------------------+
| Application Load  | <-----> | Auto Scaling EC2  | <-----> |   RDS PostgreSQL  |
|   Balancer (ALB)  |         |   Group (ASG)     |         +-------------------+
+-------------------+         +-------------------+
        |
        v
+-------------------+
|    VPC (Multi-AZ) |
+-------------------+

  [CloudTrail]   [CloudWatch]   [AWS Budgets]
      |              |               |
      +--------------+---------------+
                     |
         [ECS/ECR]   [ALB Weighted Routing]
                     |
   (All optional/advanced modules are fully integrated and referenced)
```


**Note:**
- The diagram above shows the core data and compute flow, with supporting and optional modules visually indicated below the main stack for clarity.
- All cross-cutting and supporting services (CloudTrail, CloudWatch, AWS Budgets) and all optional/advanced modules (ECS/ECR, ALB weighted routing) are now fully integrated and referenced in the root configuration. You can enable or configure any of these modules as needed by updating `terraform.tfvars`.

**Architecture Details:**
- All resources are in a single AWS region, spread across multiple AZs for HA.
- API Gateway and Lambda handle external API and inference.
- ALB and ASG manage scalable EC2-based API servers.
- S3 stores model artifacts (versioned, encrypted).
- RDS is private, encrypted, and used for metadata/logs.
- CloudTrail and CloudWatch provide audit, monitoring, log retention, and alerting.
- AWS Budgets, ECS/ECR, and ALB weighted routing are fully integrated and referenced for cost monitoring, container-based deployment, and advanced traffic management (A/B testing, blue-green deployments).
