# ECS Threat Composer Deployment

Production deployment of AWS Labs Threat Composer App using Docker, Terraform and AWS.

**Live Application**: https://awslabs.github.io/threat-composer

## Overview

This project deploys a Threat Composer App (an open-source threat modeling ecosystem managed by AWS Labs) using:

- **Cloud:** AWS (VPC, subnets, compute, ecs)
- **Infrastructure as Code:** Terraform
- **Containerisation:** Docker
- **CI/CD:** GitHub Actions (soon to be added)

## Architecture

### High-level flow:

1. Infrastructure is provisioned using Terraform:
    - Custom VPC with public/private subnets
    - Networking components (routing, gateways)
2. Application is containerised using Docker
3. Containers are deployed to AWS container-based services via ECR
4. Scripts are used to automate parts of the workflow

## Project Structure

```
threat-composer-app/
├── app/
│   ├── Dockerfile
|   ├── nginx/
|   └── ...
├── infra/
|   ├── backend.tf
|   ├── main.tf
|   ├── providers.tf
|   ├── terraform.tfvars
|   ├── variables.tf
|   └── modules
|       ├── acm/
|       ├── alb/
|       ├── ecr/
|       ├── ecs/
|       ├── iam/
|       ├── networking/
|       └── security/
|
├── images/
└── README.md