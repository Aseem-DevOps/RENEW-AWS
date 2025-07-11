# Infrastructure as Code Technical Assessment

## Overview

You have been provided with a Terraform configuration that is intended to deploy a machine learning model serving API on AWS. However, the current implementation has numerous issues including security vulnerabilities, inefficient resource allocation, missing components, and violations of best practices.

Your task is to identify these issues and provide an improved version of the infrastructure code.

## Scenario

Your company needs to deploy a production-ready API that serves machine learning models. The API should:
- Handle variable traffic loads
- Store ML models securely
- Provide low-latency inference
- Be highly available and fault-tolerant
- Follow security best practices
- Be cost-effective
- Include proper monitoring and alerting

## Current Infrastructure Components

The provided Terraform configuration attempts to create:
- VPC and networking components
- EC2 instances for the API server
- RDS PostgreSQL database for metadata
- S3 bucket for model storage
- Application Load Balancer
- Lambda functions for model inference
- API Gateway for external access
- ECS cluster for containerized workloads
- ECR repository for container images

## Your Task

1. **Review the provided `main.tf` file** and identify all issues
2. **Create an improved version** that addresses these issues
3. **Document your changes** with clear comments explaining:
   - What was wrong
   - Why it was a problem
   - How your solution fixes it
4. **Structure your solution** properly (you may split into multiple files)
5. **Include any additional components** you think are necessary

## Evaluation Criteria

Your submission will be evaluated on:

### 1. Security (30%)
- Proper security group configurations
- IAM permissions following least privilege principle
- Encryption at rest and in transit
- Secrets management
- Network security

### 2. Reliability & Scalability (25%)
- High availability design
- Auto-scaling configuration
- Fault tolerance
- Proper health checks
- Disaster recovery considerations

### 3. Best Practices (25%)
- Code organization and modularity
- Use of variables and outputs
- State management
- Environment separation
- Proper tagging strategy

### 4. Operational Excellence (20%)
- Monitoring and alerting
- Logging configuration
- Cost optimization
- Maintenance considerations
- Documentation quality

## Submission Requirements

Please provide:

1. **Improved Terraform configuration files**
   - Well-organized and commented
   - Following Terraform best practices
   - Ready for deployment (though we won't actually deploy it)

2. **A summary document** (`IMPROVEMENTS.md`) that includes:
   - List of identified issues (categorized by severity)
   - Explanation of your fixes
   - Any assumptions you made
   - Suggested next steps or future improvements

3. **Basic documentation** including:
   - Architecture diagram (can be ASCII or a simple sketch)
   - Deployment instructions
   - Any prerequisites or dependencies

## Time Expectation

This task should take approximately 2-3 hours to complete. We're not looking for perfection, but rather your ability to:
- Identify critical issues
- Prioritize fixes appropriately
- Demonstrate knowledge of AWS and Terraform best practices
- Communicate your reasoning clearly

## Getting Started

1. Clone this repository
2. Review the `main.tf` file in detail
3. Create your improved version
4. Document your changes
5. Submit your solution as directed by your interviewer

## Notes

- You don't need to make the configuration deployable with real AWS credentials
- Focus on the infrastructure code quality rather than application code
- If you identify issues that would require significant architectural changes, document them in your summary rather than implementing everything
- Feel free to make reasonable assumptions about the use case, but document them

## Questions?

If you have any questions about the requirements or need clarification on the scenario, please reach out to your interviewer.

Good luck!