# AWS SYSTEM ADMINISTRATOR _ TERRAFORM TEST _ ASEEM S

## Infra Modules Usage

All infrastructure resources are defined as reusable modules in the `modules` directory. The root `main.tf` instantiates and wires up these modules for a complete, production-ready AWS ML API deployment.

### How to Use

1. **Configure Variables:**
   - Edit `terraform.tfvars` to set values for all required and optional variables. Sample values are provided for every module.
2. **Initialize Terraform:**
   - Run `terraform init` in the `infra` directory to initialize the working directory and download providers.
3. **Plan and Apply:**
   - Run `terraform plan` to review changes, then `terraform apply` to deploy the infrastructure.
4. **State Management:**
   - By default, state is local. For production, uncomment and configure `backend.tf` for remote state (S3 + DynamoDB recommended).
5. **Environment Separation:**
   - Use Terraform workspaces or separate state files for dev/prod environments.

### Extensibility

- **Optional modules** (ECS/ECR, ALB weighted routing, AWS Budgets, etc.) are fully integrated and can be enabled/configured via `terraform.tfvars`.
- All modules are production-ready, follow AWS best practices, and are documented with sample variable values.

### Documentation

- See `IMPROVEMENTS.md` for a summary of issues, fixes, and recommendations.
- See `ARCHITECTURE.md` for a high-level architecture diagram and details.
- See `RUNBOOK.md` for operational guidance.
- See `task-observations.md` for a summary of the review and solution process.

