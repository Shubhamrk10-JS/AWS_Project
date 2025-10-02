resource "aws_subnet" "Pub_Subnet_1c" {
  
  vpc_id = aws_vpc.MyVPC.id

  availability_zone = var.Availability_zone_1c

  cidr_block = var.public_subnet_1c_cidr

  tags = {
    Name = "Public Subnet 1c"  }
}

resource "aws_subnet" "Pvt_Subnet_1c" {
  
  vpc_id = aws_vpc.MyVPC.id

  availability_zone = var.Availability_zone_1c

  cidr_block = var.private_subnet_1c_cidr

  tags = {
    Name = "Private Subnet 1c"  }
}

variable "Availability_zone_1c" {}
variable "public_subnet_1c_cidr" {}
variable "private_subnet_1c_cidr" {}