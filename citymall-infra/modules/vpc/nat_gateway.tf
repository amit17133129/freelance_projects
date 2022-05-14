resource "aws_eip" "ip" {
  count = 1
  vpc      = true
  tags = {
    Name = var.elasticip_name 
  }
}


resource "aws_nat_gateway" "nat-gateway" {
  count = 1
  allocation_id = "${aws_eip.ip[count.index].id}"
  subnet_id     = "${aws_subnet.private-subnets[count.index].id}"
  tags = {
    Name = "${var.env}-${var.nat_gateway_name}"
    env  = var.env
  }
}

resource "aws_route_table" "routeTable" {
  count = 1
  vpc_id = "${aws_vpc.vpc[count.index].id}"


  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "${aws_nat_gateway.nat-gateway[count.index].id}"
  }

  tags = {
    Name = "${var.env}-nat-gateway"
  }
}

resource "aws_route_table_association" "associate2" {
  count          = 3
  subnet_id      = "${aws_subnet.private-subnets[count.index].id}"
  route_table_id = aws_route_table.routeTable[0].id
}