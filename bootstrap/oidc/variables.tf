variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-2"
}

variable "role_name" {
  description = "Name of the IAM role for GitHub Actions"
  type        = string
  default     = "github-actions-ecs-deploy"
}

variable "github_org" {
  description = "Your GitHub organisation or username"
  type        = string
}

variable "github_repo" {
  description = "Your GitHub repository name"
  type        = string
}

variable "allowed_subjects" {
  description = "List of GitHub OIDC subject claims allowed to assume the role."
  type        = list(string)
  default     = []
}

variable "ecr_repository_name" {
  description = "Name of the ECR repository the pipeline pushes to"
  type        = string
}

variable "ecs_task_execution_role_name" {
  description = "Name of the ECS task execution IAM role (the role ECS uses to pull images and write logs)"
  type        = string
  default     = "ecsTaskExecutionRole"
}

variable "ecs_task_role_name" {
  description = "Name of the ECS task IAM role (the role your application code assumes at runtime)"
  type        = string
  default     = "ecsTaskRole"
}