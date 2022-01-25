resource "aws_route_table" "vpc-rtb2" {
  vpc_id = "${aws_vpc.vpc_B.id}"

  route {
    cidr_block = "10.100.1.0/24"
    vpc_peering_connection_id = var.vpc_peer_connection_id
  }

  tags = {
    Name       = "vpc_B_RT_private"
  }
}





resource "aws_main_route_table_association" "main-rt-vpc-2" {
  vpc_id         = "${aws_vpc.vpc_B.id}"
  route_table_id = "${aws_route_table.vpc-rtb2.id}"
}

