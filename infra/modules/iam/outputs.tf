output "ecs_task_execution_arn" {
    value = aws_iam_role.ecs_task_execution_role.arn

    description = "ARN of ECS task execution role"
}

output "ecs_task_role_arn" {
    value = aws_iam_role.ecs_task_role.arn

    description = "ARN of ECS task role"
}

