# Get information about available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# Get the current region
data "aws_region" "current" {}

# Get the current caller identity
data "aws_caller_identity" "current" {}

# Create a VPC using data source information
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "Testing-vpc"
    Environment = var.environment
    Region      = data.aws_region.current.region
    Account     = data.aws_caller_identity.current.account_id
    CreatedBy   = "${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}"
  }
}
# Create Subnets
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_sub_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name        = "public-subnet"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.priv_sub_cidr
  availability_zone = var.availability_zone

  tags = {
    Name        = "private-subnet"
    Environment = var.environment
  }
}

# Main Route Table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "main-route-table"
    Environment = var.environment
  }
}

# Route Table Associations
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.main.id
}

# Testing Security Group
resource "aws_security_group" "Testing" {
  name        = "Testing-security-group"
  description = "Security group for testing our VPC"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Testing-security-group"
    Environment = var.environment
  }
}