resource "aws_route_table" "CRT_1a" {
  vpc_id = aws_vpc.MyVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.MyNAT_1a.id
  }
 
  tags = {
    Name = "CRT_1a"
  }
}
resource "aws_route_table" "CRT_1c" {
  vpc_id = aws_vpc.MyVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.MyNAT_1c.id
  }
 
  tags = {
    Name = "CRT_1c"
  }
}
resource "aws_route_table" "MRT_1a" {
  vpc_id = aws_vpc.MyVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
 
 

  tags = {
    Name = "MRT_1a"
  }
}

resource "aws_route_table" "MRT_1c" {
  vpc_id = aws_vpc.MyVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
 
 

  tags = {
    Name = "MRT_1c"
  }
}
resource "aws_route_table_association" "a_1a" {
  subnet_id      = aws_subnet.Pub_Subnet_1a.id
  route_table_id = aws_route_table.MRT_1a.id
}

resource "aws_route_table_association" "a_1c" {
  subnet_id      = aws_subnet.Pub_Subnet_1c.id
  route_table_id = aws_route_table.MRT_1c.id
}

resource "aws_route_table_association" "b_1a" {
  subnet_id      = aws_subnet.Pvt_Subnet_1a.id
  route_table_id = aws_route_table.CRT_1a.id
}

resource "aws_route_table_association" "b_1c" {
  subnet_id      = aws_subnet.Pvt_Subnet_1c.id
  route_table_id = aws_route_table.CRT_1c.id
}
