resource "aws_route_table" "vpc-rtb1" {
  vpc_id = "${aws_vpc.vpc_A.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc-A-igw.id}"
  }


  tags = {
    Name       = "vpc_A_RT_public"
  }
}

resource "aws_route_table" "vpc-rtb3" {
  vpc_id = "${aws_vpc.vpc_A.id}"
  
  route {
    cidr_block = "10.200.1.0/24"
    vpc_peering_connection_id = var.vpc_peer_connection_id
  }

  tags = {
    Name       = "vpc_A_RT_private"
  }
}



resource "aws_main_route_table_association" "main-rt-vpc-1" {
  vpc_id         = "${aws_vpc.vpc_A.id}"
  route_table_id = "${aws_route_table.vpc-rtb1.id}"
}



