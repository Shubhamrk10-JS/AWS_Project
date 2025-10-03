// Internet facing load balancer security group

resource "aws_security_group" "Internet-facing-lb-sg" {
  name        = "Internet-facing-lb-sg"
  description = "Internet facing load balancer security group"
  vpc_id      = aws_vpc.MyVPC.id

  tags = {
    Name = "Internet-facing-lb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "HTTPS" {
  security_group_id = aws_security_group.Internet-facing-lb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "All traffic" {
  security_group_id = aws_security_group.Internet-facing-lb-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
