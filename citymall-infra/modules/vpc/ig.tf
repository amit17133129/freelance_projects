resource "aws_internet_gateway" "vpc_igw" {
  count = 1
  vpc_id = "${aws_vpc.vpc[count.index].id}"

  tags = {
    "Name" = var.ig_name
    "env"  = var.env
  }
}