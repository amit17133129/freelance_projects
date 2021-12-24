resource "aws_route_table" "vpc-rtb2" {
  count = 1
  vpc_id = "${aws_vpc.vpc[0].id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc-1-igw[count.index].id}"
  }
  tags = {
    Name       = "vpc-0-dev-rtb"
  }
}


# resource "aws_main_route_table_association" "main-rt-vpc2" {
#   count = 1
#   vpc_id         = "${aws_vpc.vpc[count.index].id}"
#   route_table_id = "${aws_route_table.vpc-rtb2[count.index].id}"
# }

# resource "aws_route_table_association" "vpc-rtb2-subnet-association" {
#   count = 1
#   subnet_id      = aws_subnet.vpc-public-sub[count.index].id
#   route_table_id = "${aws_route_table.vpc-rtb2[count.index].id}"
# } # end resource






resource "aws_route_table" "My_VPC_PUBLIC_route_table" {
  vpc_id = aws_vpc.vpc[0].id
  tags = {
    Name = "My PUBLIC VPC Route Table"
  }
} # end resource

resource "aws_route_table" "My_VPC_PRIVATE_route_table" {
  vpc_id = aws_vpc.vpc[0].id
  tags = {
    Name = "My VPC PRIVATE Route Table"
  }
}

output private_route_table_id {
  value       = aws_route_table.My_VPC_PRIVATE_route_table.id
}




# resource "aws_route_table_association" "My_VPC_Public_association" {
#   count = 1
#   subnet_id      = aws_subnet.vpc-public-sub[count.index].id
#   route_table_id = aws_route_table.My_VPC_PUBLIC_route_table.id
# } # end resource

resource "aws_route_table_association" "My_VPC_Private_association" {
  count = 1
  subnet_id      = aws_subnet.vpc-private-sub[count.index].id
  route_table_id = aws_route_table.My_VPC_PRIVATE_route_table.id
}

resource "aws_route_table_association" "My_VPC_Private_association1" {
  count = 1
  subnet_id      = aws_subnet.vpc-public-sub[count.index].id
  route_table_id = aws_route_table.vpc-rtb2[count.index].id
}