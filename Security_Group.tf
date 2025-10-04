// Internet facing load balancer security group 

resource "aws_security_group" "internet_lb_sg" {
  name        = "Internet-facing-lb-sg"
  description = "Internet facing load balancer security group"
  vpc_id      = aws_vpc.MyVPC.id

  tags = {
    Name = "Internet-facing-lb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "internet_lb_ingress" {
  security_group_id = aws_security_group.internet_lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "internet_lb_egress" {
  security_group_id = aws_security_group.internet_lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

// Web Tier security group

resource "aws_security_group" "web_tier_sg" {
  name        = "web-tier-sg"
  description = "Internet facing load balancer security group to web tier"
  vpc_id      = aws_vpc.MyVPC.id

  tags = {
    Name = "web-tier-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "web_tier_sg_ingress" {
  security_group_id = aws_security_group.web_tier_sg.id
  referenced_security_group_id = aws_security_group.internet_lb_sg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "web_tier_sg_egress" {
  security_group_id = aws_security_group.web_tier_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
  
  }

// Internal load balancer security group

resource "aws_security_group" "internal_lb_sg" {
  name        = "internal-lb-sg"
  description = "For web tier to Internal load balancer"
  vpc_id      = aws_vpc.MyVPC.id

  tags = {
    Name = "internal-lb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "internal_lb_sg_ingress" {
  security_group_id = aws_security_group.internal_lb_sg.id
  referenced_security_group_id = aws_security_group.web_tier_sg.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "internal_lb_sg_egress" {
  security_group_id = aws_security_group.internal_lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports

  }
// App server traffic from web tier

resource "aws_security_group" "app_tier_sg" {
  name        = "app-tier-sg"
  description = "Application server security group"
  vpc_id      = aws_vpc.MyVPC.id

  tags = {
    Name = "app-tier-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "internal_lb_sg_to_app_tier" {
  security_group_id = aws_security_group.app_tier_sg.id
  referenced_security_group_id = aws_security_group.internal_lb_sg.id
  from_port = 8080
  to_port = 8080
  ip_protocol = "tcp"

}

resource "aws_vpc_security_group_egress_rule" "app_to_db" {
  security_group_id = aws_security_group.app_tier_sg.id
  referenced_security_group_id = aws_security_group.db_tier_sg.id
  ip_protocol       = "-1"
}

// DB server traffic from app tier

resource "aws_security_group" "db_tier_sg" {
  name        = "db-tier-sg"
  description = "database server security group"
  vpc_id      = aws_vpc.MyVPC.id

  tags = {
    Name = "db-tier-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "db_from_app" {
  security_group_id = aws_security_group.db_tier_sg.id
  referenced_security_group_id = aws_security_group.app_tier_sg.id
  from_port = 5432
  to_port = 5432
  ip_protocol = "tcp"

}

resource "aws_vpc_security_group_egress_rule" "db_to_app" {
  security_group_id = aws_security_group.db_tier_sg.id
  referenced_security_group_id = aws_security_group.app_tier_sg.id
  ip_protocol       = "-1"
}
