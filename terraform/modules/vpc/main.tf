/*====
The VPC
======*/
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.app}-${var.environment}-vpc"
    Environment = var.environment
  }
}


/*====
Subnets
======*/
/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.app}-${var.environment}-igw"
    Environment = var.environment
  }
}

/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  vpc                  = true
  public_ipv4_pool     = "amazon"
  network_border_group = var.region
  depends_on           = [aws_internet_gateway.ig]
}

/* NAT */
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
  depends_on    = [aws_internet_gateway.ig]

  tags = {
    Name        = "${var.app}-${var.environment}-nat"
    Environment = var.environment
  }
}

/* Public Subnet */
resource "aws_subnet" "public_subnet" {
  cidr_block              = var.public_subnet_cidr
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.availability_zone_a
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.app}-${var.environment}-public_subnet"
    Environment = var.environment
  }
}

/* Private Subnet */
resource "aws_subnet" "private_subnet" {
  cidr_block              = var.private_subnet_cidr
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.availability_zone_a
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.app}-${var.environment}-private_subnet"
    Environment = var.environment
  }
}

/* Private Subnet 2*/
resource "aws_subnet" "private_subnet_2" {
  cidr_block              = var.private_subnet_cidr_2
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.availability_zone_b
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.app}-${var.environment}-private_subnet_2"
    Environment = var.environment
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.app}-${var.environment}-private-route-table"
    Environment = var.environment
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = "${var.app}-${var.environment}-public-route-table"
    Environment = var.environment
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

/* Route table associations */
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private.id
}
