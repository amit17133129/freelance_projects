resource "aws_vpc" "vpc" {
  count = 1
  cidr_block = var.vpc_cidr_block[0]
  tags = {
    Name = "${var.env}-vpc"
    env = "${var.env}-vpc"
  }
}

