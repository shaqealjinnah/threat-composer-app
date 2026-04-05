# Create SG for ALB with inbound and outbound rules
resource "aws_security_group" "alb" {
    name = "${var.project_name}--alb_sg"
    description = "Allow HTTPS and HTTP inbound and outbound to ECS traffic"

    vpc_id = var.vpc_id

    tags = {
        Name = "${var.project_name}--alb_sg"
    }
}

resource "aws_vpc_security_group_ingress_rule" "alb_http" {
    security_group_id = aws_security_group.alb.id
    description = "Allow HTTP traffic" 

    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80
    ip_protocol = "tcp"
    to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "alb_https" {
    security_group_id = aws_security_group.alb.id
    description = "Allow HTTPS traffic" 

    cidr_ipv4 = "0.0.0.0/0"
    from_port = 443
    ip_protocol = "tcp"
    to_port = 443
}

resource "aws_vpc_security_group_egress_rule" "alb_to_ecs" {
    security_group_id = aws_security_group.alb.id
    description = "Allow outbound to ECS on port 8080"
    
    referenced_security_group_id = aws_security_group.ecs.id
    from_port = 8080
    to_port = 8080
    ip_protocol = "tcp"
}

# Create SG for ECS with inbound and outbound rules
resource "aws_security_group" "ecs" {
    name = "${var.project_name}--ecs_sg"
    description = "Allow ALB inbound and all outbound traffic"

    vpc_id = var.vpc_id

    tags = {
        Name = "${var.project_name}--ecs_sg"
    }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_from_alb" {
    security_group_id = aws_security_group.ecs.id
    description = "Allow traffic from ALB via port 8080"
    
    referenced_security_group_id = aws_security_group.alb.id
    from_port = 8080
    to_port = 8080
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "all_access" {
    security_group_id = aws_security_group.ecs.id
    description = "Allow all outbound traffic"

    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}