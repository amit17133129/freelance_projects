# # Subnets

resource "aws_subnet" "vpc-sub-1" {
  vpc_id     = "${aws_vpc.vpc_A.id}"
  cidr_block = "10.100.0.0/24"
  availability_zone = "${var.az[0]}"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public-Subnet-VPC-A"
  }
}

resource "aws_subnet" "vpc-sub-2" {
  vpc_id     =  "${aws_vpc.vpc_A.id}"
  cidr_block = "10.100.1.0/24"
  availability_zone = "${var.az[1]}"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private-Subnet-VPC-A"
  }
}




output "vpc_A_public_subnet" {
  value = aws_subnet.vpc-sub-1.id
}
output "vpc_A_private_subnet" {
  value =  aws_subnet.vpc-sub-2.id
}





resource "aws_route_table_association" "vpc-A-asso" {
  subnet_id = "${aws_subnet.vpc-sub-1.id}"  # How to put pub_subnet_azc.id into here?
  route_table_id = "${aws_route_table.vpc-rtb1.id}"
}

resource "aws_route_table_association" "vpc-A-private-asso" {
  subnet_id = "${aws_subnet.vpc-sub-2.id}"  # How to put pub_subnet_azc.id into here?
  route_table_id = "${aws_route_table.vpc-rtb3.id}"
}

