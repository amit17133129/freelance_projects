resource "aws_route_table" "vpc-rtb" {
  count = 1
  vpc_id = "${aws_vpc.vpc[0].id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc_igw[count.index].id}"
  }
  tags = {
    Name       = "vpc-0-dev-rtb"
    env        = var.env
  }
}


resource "aws_main_route_table_association" "main-rt-vpc2" {
  count = 1
  vpc_id         = "${aws_vpc.vpc[count.index].id}"
  route_table_id = "${aws_route_table.vpc-rtb[count.index].id}"
}

resource "aws_route_table_association" "subnet-asso" {
  count = 3
  subnet_id      = aws_subnet.public-subnets[count.index].id
  route_table_id = aws_route_table.vpc-rtb[0].id
}