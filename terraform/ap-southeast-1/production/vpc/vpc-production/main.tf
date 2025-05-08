resource "aws_vpc" "production" {
  cidr_block = var.vpc_production_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name        = var.vpc_name
    Environment = "infra"
  }
}

# Public Subnet
resource "aws_subnet" "production_public" {
  count = var.subnet_count
  vpc_id     = aws_vpc.production.id
  cidr_block = cidrsubnet(var.vpc_production_cidr, 8, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-${count.index}"
  }
}

# Private Subnet
resource "aws_subnet" "production_private" {
  count = var.subnet_count
  vpc_id     = aws_vpc.production.id
  cidr_block = cidrsubnet(var.vpc_production_cidr, 8, count.index + var.subnet_count)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "Private-Subnet-${count.index}"
  }
}

# Public Route Table
resource "aws_route_table" "production_public_route_table" {
  vpc_id = aws_vpc.production.id

  tags = {
    Name        = "${var.vpc_name}-public-route-table"
    Environment = "infra"
  }
}

# Private Route Table
resource "aws_route_table" "production_private_route_table" {
  vpc_id = aws_vpc.production.id

  tags = {
    Name        = "${var.vpc_name}-private-route-table"
    Environment = "infra"
  }
}

# Internet Gateway for Public Subnet
resource "aws_internet_gateway" "production_internet_gateway" {
  vpc_id = aws_vpc.production.id

  tags = {
    Name        = "${var.vpc_name}-internet-gateway"
    Environment = "infra"
  }
}

# Route for Public Subnet to the Internet Gateway
resource "aws_route" "production_internet_gateway_route" {
  route_table_id         = aws_route_table.production_public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.production_internet_gateway.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  tags = {
    Name = "${var.vpc_name}-eip-nat"
  }
}

# NAT Gateway in Public Subnet
resource "aws_nat_gateway" "production_nat_gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.production_public[0].id
  tags = {
    Name        = "${var.vpc_name}-nat-gateway"
    Environment = "infra"
  }
}

# Route for Private Subnet to the NAT Gateway
resource "aws_route" "production_private_nat_route" {
  route_table_id         = aws_route_table.production_private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.production_nat_gateway.id
}

# Association Route Table for Public Subnets
resource "aws_route_table_association" "production_public_route_association" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.production_public[count.index].id
  route_table_id = aws_route_table.production_public_route_table.id
}

# Association Route Table for Private Subnets
resource "aws_route_table_association" "production_private_route_association" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.production_private[count.index].id
  route_table_id = aws_route_table.production_private_route_table.id
}
