resource "aws_vpc" "wiz-vpc" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "wiz-vpc"
  }
}

resource "aws_subnet" "wiz-public-subnet" {
  vpc_id     = aws_vpc.wiz-vpc.id
  cidr_block = "192.168.150.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"

  tags = {
    Name = "wiz-public-subnet"
  }
}

resource "aws_subnet" "wiz-private-subnet" {
  vpc_id     = aws_vpc.wiz-vpc.id
  cidr_block = "192.168.151.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1a"

  tags = {
    Name = "wiz-private-subnet"
  }
}

resource "aws_subnet" "wiz-private-subnet2" {
  vpc_id     = aws_vpc.wiz-vpc.id
  cidr_block = "192.168.152.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1b"

  tags = {
    Name = "wiz-private-subnet2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "wiz-inet" {
  vpc_id = aws_vpc.wiz-vpc.id

  tags = {
    Name = "wiz-inet"
  }
}

resource "aws_route_table" "wiz-rt-inet" {
  vpc_id = aws_vpc.wiz-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.wiz-inet.id
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "wiz-rt-inet-public-subnet" {
  subnet_id      = aws_subnet.wiz-public-subnet.id
  route_table_id = aws_route_table.wiz-rt-inet.id
}

# Associate the route table with the subnet
resource "aws_route_table_association" "wiz-rt-inet-private-subnet" {
  subnet_id      = aws_subnet.wiz-private-subnet.id
  route_table_id = aws_route_table.wiz-rt-inet.id
}

# Associate the route table with the subnet
resource "aws_route_table_association" "wiz-rt-inet-private-subnet2" {
  subnet_id      = aws_subnet.wiz-private-subnet2.id
  route_table_id = aws_route_table.wiz-rt-inet.id
}
