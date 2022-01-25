
resource "aws_subnet" "vpc-sub-3" {
  vpc_id     = "${aws_vpc.vpc_B.id}"
  cidr_block = "10.200.1.0/24"
  availability_zone = "${var.az[1]}"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private-Subnet-VPC-B"
  }
}


output "vpc_B_private_subnet" {
  value =  aws_subnet.vpc-sub-3.id
}




resource "aws_route_table_association" "vpc-B-asso" {
  subnet_id = "${aws_subnet.vpc-sub-3.id}"  # How to put pub_subnet_azc.id into here?
  route_table_id = "${aws_route_table.vpc-rtb2.id}"
}