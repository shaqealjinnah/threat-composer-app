variable "project_name" {
    type = string
    description = "Name of the project"

    default = "threat-composer"
}

variable "aws_region" {
    type = string
    description = "AWS Region"
}

variable "vpc_cidr" {
    type = string
    description = "CIDR for VPC"
}

variable "availability_zones" {
    type = list(string)
    description = "List of Availability Zones"
}

variable "public_subnet_cidr" {
    type = list(string)
    description = "List of CIDR for Public Subnets"
}

variable "private_subnet_cidr" {
    type = list(string)
    description = "List of CIDR for Private Subnets"
}