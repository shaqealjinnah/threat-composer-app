variable "project_name" {
    type = string
    description = "Name of the project"
}

variable "ecs_task_execution_arn" {
    type = string
    description = "ARN of ECS task execution role"
}

variable "ecs_task_role_arn" {
    type = string
    description = "ARN of ECS task role"
}

variable "container_port" {
    type = number
    description = "Port number of the container"
}

variable "image_url" {
    type = string
    description = "Docker image URL"
}