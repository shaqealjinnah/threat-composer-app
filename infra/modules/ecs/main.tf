# Create ECS Cluster
resource "aws_ecs_cluster" "main" {
    name = "${var.project_name}--ecs-cluster"

    setting {
        name  = "containerInsights"
        value = "disabled"
    }

    tags = {
        Name = "${var.project_name}--ecs-cluster"
    }
}

# Define Task Definition Blueprint
resource "aws_ecs_task_definition" "main" {
    family = "main"
    requires_compatibilities = ["FARGATE"]
    network_mode = "awsvpc"

    cpu = "256"
    memory = "512"

    execution_role_arn = var.ecs_task_execution_arn
    task_role_arn = var.ecs_task_role_arn

    container_definitions = jsonencode([
        {
            name = "app"
            image = "${var.image_url}:latest"
            essential = true
            portMappings = [
                {
                    containerPort = var.container_port
                    hostPort = var.container_port
                }
            ]
        }])

    tags = {
        Name =  "${var.project_name}--task-definition"
    }
}