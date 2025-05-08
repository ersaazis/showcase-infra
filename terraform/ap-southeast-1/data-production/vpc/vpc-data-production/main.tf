resource "aws_vpc" "data_production" {
  cidr_block = var.vpc_data_production_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name        = var.vpc_name
    Environment = "infra"
  }
}

resource "aws_subnet" "data_production_public" {
  count = var.subnet_count
  vpc_id     = aws_vpc.data_production.id
  cidr_block = cidrsubnet(var.vpc_data_production_cidr, 8, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-${count.index}"
  }
}

resource "aws_subnet" "data_production_private" {
  count = var.subnet_count
  vpc_id     = aws_vpc.data_production.id
  cidr_block = cidrsubnet(var.vpc_data_production_cidr, 8, count.index + var.subnet_count)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "Private-Subnet-${count.index}"
  }
}

resource "aws_route_table" "data_production_route_table" {
  vpc_id = aws_vpc.data_production.id

  tags = {
    Name        = "${var.vpc_name}-route-table"
    Environment = "infra"
  }
}

resource "aws_internet_gateway" "data_production_internet_gateway" {
  vpc_id = aws_vpc.data_production.id

  tags = {
    Name        = "${var.vpc_name}-internet-gateway"
    Environment = "infra"
  }
}

resource "aws_route" "data_production_internet_gateway_route" {
  route_table_id         = aws_route_table.data_production_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.data_production_internet_gateway.id
}
