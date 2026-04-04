# Create Custom VPC
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    
    tags = {
        Name = "${var.project_name}--vpc"
    }
}

# Create Subnets
resource "aws_subnet" "public" {
    count = 2
    vpc_id = aws_vpc.main.id
    availability_zone = var.availability_zones[count.index]
    cidr_block = var.public_subnet_cidr[count.index]

    map_public_ip_on_launch = true

    tags = {
        Name = "${var.project_name}--public-subnet-${count.index + 1}"
    }
}

resource "aws_subnet" "private" {
    count = 2
    vpc_id = aws_vpc.main.id
    availability_zone = var.availability_zones[count.index]
    cidr_block = var.private_subnet_cidr[count.index]

    tags = {
        Name = "${var.project_name}--private-subnet-${count.index + 1}"
    }
}

# Attach Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.project_name}--igw"
    }
}

# Create Public Route Table and Configure Routes
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.project_name}--public-route_table"
    }
}

resource "aws_route" "internet_access" {
    route_table_id = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
    count = length(aws_subnet.public)

    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
    count = 2
    domain = "vpc"

    tags = {
        Name = "${var.project_name}--eip-${count.index + 1}"
    }

}

resource "aws_nat_gateway" "public" {
    count = length(aws_subnet.public)

    subnet_id = aws_subnet.public[count.index].id
    allocation_id = aws_eip.nat[count.index].id

    depends_on = [aws_internet_gateway.igw]

    tags = {
        Name = "${var.project_name}--nat-gateway-${count.index + 1}"
    }
}

# Create Private Route Table and Configure Routes
resource "aws_route_table" "private" {
    count = length(aws_subnet.private)
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "${var.project_name}--private-route_table-${count.index + 1}"
    }
}

resource "aws_route" "private_nat" {
    count = length(aws_nat_gateway.public)

    route_table_id = aws_route_table.private[count.index].id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public[count.index].id
}

resource "aws_route_table_association" "private" {
    count = length(aws_subnet.private)

    subnet_id = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private[count.index].id
}