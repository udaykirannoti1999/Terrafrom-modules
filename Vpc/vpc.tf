#Create VPC

resource "aws_vpc" "yuma" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = var.vpc_name
  }
}

#Create Subnet

resource "aws_subnet" "yuma_public" {
  count                = length(data.aws_availability_zones.azs.names)
  availability_zone    = element(data.aws_availability_zones.azs.names, count.index)
  vpc_id               = var.vpc_id
  cidr_block           = element(var.public_subnet_cidr, count.index)
  ipv6_cidr_block      = cidrsubnet(aws_vpc.yuma.ipv6_cidr_block, 8, count.index)

  tags = {
    Name  = "${var.vpc_name}/${var.public_subnet_name}${count.index + 1}"
    State = "Public"
  }
}

#Create Private Subnets for DB
resource "aws_subnet" "yuma_private" {
  count                = length(data.aws_availability_zones.azs.names)
  availability_zone    = element(data.aws_availability_zones.azs.names, count.index)
  vpc_id               = var.vpc_id
  cidr_block           = element(var.private_subnet_cidr, count.index)

  tags = {
    Name = "${var.vpc_name}/${var.private_subnet_name}${count.index + 1}"
    State = "Private-DB"
  }
}

#Create Private Subnets for Apps

resource "aws_subnet" "yuma_apps_private" {
  count                = length(data.aws_availability_zones.azs.names)
  availability_zone    = element(data.aws_availability_zones.azs.names, count.index)
  vpc_id               = var.vpc_id
  cidr_block           = element(var.private_apps_subnet_cidr, count.index)

  tags = {
    Name = "${var.vpc_name}/${var.private_apps_subnet_name}${count.index + 1}"
    State = "Private-Apps"
  }
}

#Create aws_internet_gateway
resource "aws_internet_gateway" "yuma_ig" {
  vpc_id = var.vpc_id
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_eip" "yuma_eip" {
 domain = "vpc"
  tags = {
   Name = "${var.vpc_name}/${var.eip_name}"
  }
}

#Create NAT Gateway

 resource "aws_nat_gateway" "yuma_nat" {
  allocation_id = aws_eip.yuma_eip.id
   subnet_id     = aws_subnet.yuma_public[0].id

  tags = {
  Name = "${var.vpc_name}/${var.nat_gateway_name}"
 }
 } 

#Create public Route Table

resource "aws_route_table" "yuma_public_route" {
  count  = length(aws_subnet.yuma_public.*.id)
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.yuma_ig.id
  }
  tags = {
    Name = "${var.vpc_name}/${var.public_route_table_name}${count.index + 1}"
  }
}

#Create private Route Table apps DB

resource "aws_route_table" "yuma_private_route" {
  count  = length(aws_subnet.yuma_private.*.id)
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.vpc_name}/${var.private_route_table_name}${count.index + 1}"
  }
}

#Create private Route Table for apps

resource "aws_route_table" "yuma_apps_private_route" {
  count  = length(aws_subnet.yuma_apps_private.*.id)
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id     = aws_internet_gateway.yuma_ig.id
  }

  tags = {
    Name = "${var.vpc_name}/${var.private_apps_route_table_name}${count.index + 1}"
  }
}

#subet assoiciation with public route Table

resource "aws_route_table_association" "yuma_public_route" {

  count          = length(aws_route_table.yuma_public_route.*.id)
  subnet_id      = element(aws_subnet.yuma_public.*.id, count.index)
  route_table_id = element(aws_route_table.yuma_public_route.*.id, count.index)
}

#subet assoiciation with private DB route Table

resource "aws_route_table_association" "yuma_private_route" {

  count          = length(aws_route_table.yuma_private_route.*.id)
  subnet_id      = element(aws_subnet.yuma_private.*.id, count.index)
  route_table_id = element(aws_route_table.yuma_private_route.*.id, count.index)
}

#subet assoiciation with private apps route Table

resource "aws_route_table_association" "yuma_apps_private_route" {

  count          = length(aws_route_table.yuma_apps_private_route.*.id)
  subnet_id      = element(aws_subnet.yuma_apps_private.*.id, count.index)
  route_table_id = element(aws_route_table.yuma_apps_private_route.*.id, count.index)
}

resource "aws_vpc_endpoint" "yuma" {
  vpc_id            = aws_vpc.yuma.id
  service_name      = var.endpoint_service_name
  vpc_endpoint_type = var.endpoint_type
  route_table_ids   = aws_route_table.yuma_apps_private_route.*.id

  tags = {
    Name = var.endpoint_name
  }
}

resource "aws_default_security_group" "yuma" {
  vpc_id = var.vpc_id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }
}

output "vpc_id" {
  value = aws_vpc.yuma.id
}

output "ipv6_cidr" {
  value = aws_vpc.yuma.ipv6_cidr_block
}

output "public_subnet_ids" {
  value = aws_subnet.yuma_public.*.id
}

output "private_subnet_ids" {
  value = aws_subnet.yuma_private.*.id
}

output "private_apps_subnet_ids" {
  value = aws_subnet.yuma_apps_private.*.id
}
