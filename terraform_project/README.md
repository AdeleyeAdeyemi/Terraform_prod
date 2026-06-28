# Terraform Project

This repository contains a modular Terraform setup for provisioning AWS infrastructure across multiple environments: `dev`, `stage`, and `prod`.

## Project Structure

- `backend.tf` - Root backend configuration (local state in the current setup)
- `main.tf` - Root module orchestration for the environment-level deployment
- `variables.tf` - Root input variables for the project
- `shared/` - Shared configuration files like provider and locals
- `global_variables/` - Global variable definitions used across modules
- `modules/` - Reusable Terraform modules:
  - `vpc/`
  - `subnet/`
  - `route_table/`
  - `security_group/`
  - `ec2/`
  - `alb/`
  - `autoscaling/`
  - `rds/`
  - `s3/`
- `environments/` - Environment-specific deployment layers:
  - `dev/`
  - `stage/`
  - `prod/`

## What this Project Deploys

The Terraform configuration is designed to create a typical AWS application stack including:

- VPC with public and private subnets
- Internet Gateway and route tables
- Security groups for SSH, HTTP, and HTTPS
- EC2 instances
- Application Load Balancer
- Auto Scaling Group
- RDS database instance
- S3 bucket

## Environment Setup

Each environment has its own directory and configuration files:

- `environments/dev/`
- `environments/stage/`
- `environments/prod/`

Each environment directory contains:

- `main.tf` - Environment module wiring
- `variables.tf` - Declared environment inputs
- `terraform.tfvars` - Actual environment-specific values
- `backend.tf` - Backend configuration (local state)
- `versions.tf` - Provider and Terraform version constraints

## Local Execution

This repo is currently configured to use a local state backend, so AWS credentials are not required for initialization.

To initialize and apply an environment:

```bash
cd terraform_project/environments/dev
terraform init
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

Replace `dev` with `stage` or `prod` to target the other environments.

## Notes

- If you want to use AWS backend state later, update the `backend.tf` files to use S3 and remove the local backend configuration.
- Sensitive values like `db_password` are currently set in `terraform.tfvars` for convenience; using a secrets manager is recommended for production.
- The project uses AWS provider version `~> 5.0`.

## Recommended Improvements

- Add remote backend support for production state storage
- Use IAM roles or AWS profiles for authentication instead of environment variables
- Replace plain-text secrets with Vault or AWS Secrets Manager
- Add `outputs.tf` to root environments for useful exported values
