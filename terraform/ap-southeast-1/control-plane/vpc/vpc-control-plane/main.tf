resource "aws_vpc" "control_plane" {
  cidr_block = var.vpc_control_plane_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name        = var.vpc_name
    Environment = "infra"
  }
}

resource "aws_subnet" "control_plane_public" {
  count = var.subnet_count
  vpc_id     = aws_vpc.control_plane.id
  cidr_block = cidrsubnet(var.vpc_control_plane_cidr, 8, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-${count.index}"
  }
}

resource "aws_subnet" "control_plane_private" {
  count = var.subnet_count
  vpc_id     = aws_vpc.control_plane.id
  cidr_block = cidrsubnet(var.vpc_control_plane_cidr, 8, count.index + var.subnet_count)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "Private-Subnet-${count.index}"
  }
}

resource "aws_route_table" "control_plane_route_table" {
  vpc_id = aws_vpc.control_plane.id

  tags = {
    Name        = "${var.vpc_name}-route-table"
    Environment = "infra"
  }
}

resource "aws_internet_gateway" "control_plane_internet_gateway" {
  vpc_id = aws_vpc.control_plane.id

  tags = {
    Name        = "${var.vpc_name}-internet-gateway"
    Environment = "infra"
  }
}

resource "aws_route" "control_plane_internet_gateway_route" {
  route_table_id         = aws_route_table.control_plane_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.control_plane_internet_gateway.id
}
