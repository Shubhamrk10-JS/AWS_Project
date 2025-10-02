resource "aws_vpc" "MyVPC" {

    //region = var.myRegion1
    cidr_block = var.VPCCIDR

    tags =  {
        Name = "var.MyVPC"
    }
}
variable "VPCCIDR" {}
variable "MyVPC" {}