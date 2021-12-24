resource "aws_internet_gateway" "vpc-1-igw" {
  count = 1
  vpc_id = "${aws_vpc.vpc[count.index].id}"

  tags = {
    Name = var.ig_name
  }
}