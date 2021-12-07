###############################################################
#                    Availibility Zones
###############################################################

data "aws_availability_zones" "az" {
  state = "available"
}

###############################################################
#                           VPC
###############################################################

resource "aws_vpc" "terra-vpc" {
  cidr_block                = var.vpc_cidr
  instance_tenancy          = "default"
  enable_dns_hostnames      = true
  enable_dns_support        = true

  tags  = {
    Name  = "${var.project}-vpc"
  }
  lifecycle {
    create_before_destroy   = true
  }
}

###############################################################
#                      Internet Gateway
###############################################################

resource "aws_internet_gateway" "igw" {
  vpc_id  = aws_vpc.terra-vpc.id

  tags  = {
    Name  = "${var.project}-igw"
  }
}

###############################################################
#                        Public Subnet 1
###############################################################

resource "aws_subnet" "public1" {
  vpc_id                      = aws_vpc.terra-vpc.id
  cidr_block                  = cidrsubnet(var.vpc_cidr, 3, 0)
  map_public_ip_on_launch     = true
  availability_zone           = data.aws_availability_zones.az.names[0]

  tags  = {
    Name  = "${var.project}-public1"
  }
}

###############################################################
#                        Public Subnet 2
###############################################################

resource "aws_subnet" "public2" {
  vpc_id                      = aws_vpc.terra-vpc.id
  cidr_block                  = cidrsubnet(var.vpc_cidr, 3, 1)
  map_public_ip_on_launch     = true
  availability_zone           = data.aws_availability_zones.az.names[1]

  tags  = {
    Name  = "${var.project}-public2"
  }
}

###############################################################
#                        Public Subnet 3
###############################################################

resource "aws_subnet" "public3" {
  vpc_id                      = aws_vpc.terra-vpc.id
  cidr_block                  = cidrsubnet(var.vpc_cidr, 3, 2)
  map_public_ip_on_launch     = true
  availability_zone           = data.aws_availability_zones.az.names[2]

  tags  = {
    Name  = "${var.project}-public3"
  }
}

###############################################################
#                        Private Subnet 1
###############################################################

resource "aws_subnet" "private1" {
  vpc_id                      = aws_vpc.terra-vpc.id
  cidr_block                  = cidrsubnet(var.vpc_cidr, 3, 3)
  map_public_ip_on_launch     = false
  availability_zone           = data.aws_availability_zones.az.names[0]

  tags  = {
    Name  = "${var.project}-private1"
  }
}

###############################################################
#                        Private Subnet 2
###############################################################

resource "aws_subnet" "private2" {
  vpc_id                      = aws_vpc.terra-vpc.id
  cidr_block                  = cidrsubnet(var.vpc_cidr, 3, 4)
  map_public_ip_on_launch     = false
  availability_zone           = data.aws_availability_zones.az.names[1]

  tags  = {
    Name  = "${var.project}-private2"
  }
}

###############################################################
#                        Private Subnet 3
###############################################################

resource "aws_subnet" "private3" {
  vpc_id                      = aws_vpc.terra-vpc.id
  cidr_block                  = cidrsubnet(var.vpc_cidr, 3, 5)
  map_public_ip_on_launch     = false
  availability_zone           = data.aws_availability_zones.az.names[2]

  tags  = {
    Name  = "${var.project}-private3"
  }
}

###############################################################
#                   Elastic Ip for NAT Gateway
###############################################################

resource "aws_eip" "eip" {
  vpc      = true
  tags = {
    Name = "${var.project}-eip"
  }
}

###############################################################
#                          NAT Gateway
###############################################################

resource "aws_nat_gateway" "nat-gw" {
  allocation_id     = aws_eip.eip.id
  subnet_id         = aws_subnet.public1.id

  tags = {
    Name = "${var.project}-nat-gw"
  }
}

###############################################################
#                     Public Route Table
###############################################################

resource "aws_route_table" "public-route" {
  vpc_id          = aws_vpc.terra-vpc.id

  route {
    cidr_block    = "0.0.0.0/0"
    gateway_id    = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.project}-public-route"
  }
}

###############################################################
#                     Private Route Table
###############################################################

resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.terra-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name = "${var.project}-private-route"
  }
}

###############################################################
#                   Route Table Association
###############################################################

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "public3" {
  subnet_id      = aws_subnet.public3.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private-route.id
}

resource "aws_route_table_association" "private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private-route.id
}
resource "aws_route_table_association" "private3" {
  subnet_id      = aws_subnet.private3.id
  route_table_id = aws_route_table.private-route.id
}
                     
                     
