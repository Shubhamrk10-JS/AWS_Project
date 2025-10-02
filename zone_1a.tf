
resource "aws_subnet" "Pub_Subnet_1a" {
  
  vpc_id = aws_vpc.MyVPC.id

  availability_zone = var.Availability_zone_1a

  cidr_block = var.public_subnet_1a_cidr

  tags = {
    Name = "Public Subnet 1a"  }
}

resource "aws_subnet" "Pvt_Subnet_1a" {
  
  vpc_id = aws_vpc.MyVPC.id

  availability_zone = var.Availability_zone_1a

  cidr_block = var.private_subnet_1a_cidr

  tags = {
    Name = "Private Subnet 1a"  }
}

variable "Availability_zone_1a" {}
variable "public_subnet_1a_cidr" {}


variable "private_subnet_1a_cidr" {}