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

# Create ECS Service
resource "aws_ecs_service" "app" {
    name = "${var.project_name}--ecs-service"
    cluster = aws_ecs_cluster.main.id
    task_definition = aws_ecs_task_definition.main.arn
    desired_count = var.desired_count
    launch_type = "FARGATE"
    health_check_grace_period_seconds = 60
    
    network_configuration {
        assign_public_ip = false
        security_groups = [var.ecs_sg_id]
        subnets = var.private_subnet_ids
    }

    load_balancer {
        container_name = "app"
        container_port = var.container_port
        target_group_arn = var.target_group_arn
    }

    depends_on = [var.http_listener_arn, var.https_listener_arn]

    tags = {
        Name = "${var.project_name}--ecs-service"
    }
}