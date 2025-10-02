resource "aws_eip" "lb" {
  
  domain   = "vpc"
}
resource "aws_eip" "lb1" {
  
  domain   = "vpc"
}
resource "aws_nat_gateway" "MyNAT_1a" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.Pub_Subnet_1a.id

  tags = {
    Name = "NAT_1a"
  }

}

resource "aws_nat_gateway" "MyNAT_1c" {
  allocation_id = aws_eip.lb1.id
  subnet_id     = aws_subnet.Pub_Subnet_1c.id

  tags = {
    Name = "NAT_1c"
  }

}