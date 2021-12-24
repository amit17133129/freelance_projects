# # Subnets

resource "aws_subnet" "vpc-sub-1" {
  count      = length(var.vpc_sub_1)
  vpc_id     = "${aws_vpc.vpc[count.index].id}"
  cidr_block = var.vpc_sub_1_cidr[count.index]
  availability_zone = "${var.az[count.index]}"
  map_public_ip_on_launch = var.map_public_ip_on_launch[count.index]
  tags = {
    Name = "${var.env[count.index]}-${var.vpc_sub_1[count.index]}"
  }
}

resource "aws_subnet" "vpc-sub-2" {
  count      = length(var.vpc_sub_2)
  vpc_id     = "${aws_vpc.vpc[count.index].id}"
  cidr_block = var.vpc_sub_2_cidr[count.index]
  availability_zone = "${var.az1[count.index]}"
  map_public_ip_on_launch = var.map_public_ip_on_launch_1[count.index]
  tags = {
    Name = "${var.env[count.index]}-${var.vpc_sub_2[count.index]}"
  }
}

output "vpc_1_2_3_sub_a" {
  value = aws_subnet.vpc-sub-1[*].id
}
output "vpc_1_2_3_sub_b" {
  value =  aws_subnet.vpc-sub-2[*].id
}
