resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_vpc
  tags = {
    Name = "vpc-${var.environment}-terraform"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.cidr_subnet

  tags = {
    Name = "subnet-${var.environment}-terraform"
  }
}

resource "aws_internet_gateway" "internet_gateway" {

  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "internet-gateway-${var.environment}-terraform"
  }
}


resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0" #abre o internet gateway para internet
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "route-table-${var.environment}-terraform"
  }
}

resource "aws_route_table_association" "rout_table_association" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.route_table.id
}


resource "aws_security_group" "security_group" {
  name        = "security-group-terraform"
  description = "Allow SSH"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "security-group-${var.environment}-terraform"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  description       = "Allow SSH"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

 