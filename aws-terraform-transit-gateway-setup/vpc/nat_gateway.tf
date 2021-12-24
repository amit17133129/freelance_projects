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
  subnet_id     = "${aws_subnet.vpc-sub-2[count.index].id}"


  tags = {
    Name = var.nat_gateway_name
  }
}

resource "aws_route_table" "t4routeTable-2" {
  count = 1
  vpc_id = "${aws_vpc.vpc[count.index].id}"


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.nat-gateway[count.index].id}"
  }

  tags = {
    Name = "nat-gateway-vpc-${count.index}"
  }
}



resource "aws_route_table_association" "associate2" {
  count          = 1
  subnet_id      = "${aws_subnet.vpc-sub-2[count.index].id}"
  route_table_id = aws_route_table.t4routeTable-2[count.index].id
}