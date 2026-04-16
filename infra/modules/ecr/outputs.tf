output "image_url" {
    value = aws_ecr_repository.app.repository_url

    description = "Docker image URL"
}