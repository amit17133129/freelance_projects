# # Subnets
resource "aws_subnet" "vpc-public-sub" {
  count      = length(var.public_subnet)
  vpc_id     = "${aws_vpc.vpc[count.index].id}"
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = "${var.public_az}"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.public_subnet[count.index]}"
  }
}

resource "aws_subnet" "vpc-private-sub" {
  count      = length(var.private_subnet)
  vpc_id     = "${aws_vpc.vpc[count.index].id}"
  cidr_block = var.private_subnet_cidr[count.index]
  availability_zone = "${var.private_az}"
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.private_subnet[count.index]}"
  }
}

output "public_subnet" {
  value = aws_subnet.vpc-public-sub[*].id
}
output "private_subnet" {
  value =  aws_subnet.vpc-private-sub[*].id
}
