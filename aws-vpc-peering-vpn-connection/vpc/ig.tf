resource "aws_internet_gateway" "vpc-A-igw" {
  vpc_id = "${aws_vpc.vpc_A.id}"

  tags = {
    Name = var.ig_name
  }
}