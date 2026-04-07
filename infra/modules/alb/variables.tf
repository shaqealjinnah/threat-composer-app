variable "project_name" {
    type = string
    description = "Name of the project"
}

variable "alb_sg_id" {
    type = string
    description = "ALB security group ID"
}

variable "public_subnet_ids" {
    type = list(string)
    description = "Public Subnet IDs"
}

variable "container_port" {
    type = number
    description = "The port for the containers"
}

variable "vpc_id" {
    type = string
    description = "The ID of the VPC"
}

variable "acm_arn" {
    type = string
    description = "The ARN of the ACM certificate"
}