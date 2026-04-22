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

variable "ecs_sg_id" {
    type = string
    description = "ID of ECS security group"
}

variable "private_subnet_ids" {
    type = list(string)
    description = "List of CIDR for Private Subnets"
}

variable "target_group_arn" {
    type = string
    description = "ARN of ALB's target group"
}

variable "desired_count" {
    type = number
    description = "Number of ECS Instances"
}

variable "http_listener_arn" {
    type = string
    description = "Target group listener ARN"
}

variable "https_listener_arn" {
    type = string
    description = "Target group listener ARN"
}