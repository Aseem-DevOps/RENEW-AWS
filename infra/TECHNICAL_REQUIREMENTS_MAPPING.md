# Mapping of Technical Requirements to Terraform Infrastructure (infra/)

This document explicitly maps the technical requirements from `infrastructure-requirements.md` to the Terraform configuration and modules in the `infra/` folder.

---

## 1. API Requirements
- **RESTful API, JSON, Batch, Auth, Rate Limiting**
  - **infra/modules/apigateway/**: Defines API Gateway for RESTful endpoints, JSON support, batch requests, API key authentication, and rate limiting.
  - **infra/modules/lambda/** or **infra/modules/ecs/**: Hosts Python-based model serving containers (e.g., FastAPI, Flask, or custom Python server).

## 2. Model Storage
- **Secure, Versioned, Fast, Multi-format**
  - **infra/modules/storage/**: Provisions S3 buckets for model artifacts with versioning, encryption, and access controls.
  - **infra/modules/iam/**: IAM roles/policies for least-privilege access to S3.

## 3. Database Requirements
- **Metadata, Logs, Analytics, Retention**
  - **infra/modules/database/**: Provisions RDS (PostgreSQL/MySQL) or DynamoDB for metadata and logs, with encryption, no public access, and retention policies.
  - **infra/modules/security/**: Security groups and subnet configuration to restrict DB access.

## 4. Security Requirements
- **Encryption, No Public DB, Least Privilege, Audit, SOC2**
  - **infra/modules/security/**: Security groups, VPC, subnets, and NACLs for network isolation.
  - **infra/modules/iam/**: IAM policies for least privilege.
  - **infra/modules/cloudtrail/**: Enables audit logging for all infrastructure changes.
  - **infra/modules/compute/**: Ensures encryption at rest for EBS volumes.

## 5. Operational Requirements
- **Automated Deploy, Blue-Green, Monitoring, Backups, Cost**
  - **infra/main.tf**: Integrates all modules for automated deployment.
  - **infra/modules/ecs/** or **infra/modules/lambda/**: Supports blue-green deployments.
  - **infra/modules/cloudwatch/**: Monitoring, alerting, and log aggregation.
  - **infra/modules/database/**: Automated backups and point-in-time recovery.
  - **infra/modules/awsbudgets/**: Cost visibility and alerts.

## 6. Performance Requirements
- **Auto-scale, Spikes, Cold Start, Single Region**
  - **infra/modules/autoscaling/**: Auto-scaling groups for ECS or EC2 based on CPU/memory.
  - **infra/modules/ecs/** or **infra/modules/lambda/**: Handles cold start and scaling.
  - **infra/provider.tf**: Sets AWS region.

---

## Notes
- All modules are orchestrated in `infra/main.tf`.
- Variables and outputs are managed in each module's `variables.tf` and `outputs.tf`.
- Security, cost, and operational best practices are enforced via dedicated modules.

---

**This mapping ensures that each technical requirement is explicitly addressed by the Terraform infrastructure in the `infra/` folder.**
