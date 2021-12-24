resource "aws_route_table" "vpc-rtb" {
  count = 1
  vpc_id = "${aws_vpc.vpc[1].id}"

  route {
    cidr_block = var.vpc_rtb_cidr_block 
    transit_gateway_id = var.test_tgw_id#"${aws_ec2_transit_gateway.test-tgw.id}"
  }
  tags = {
    Name       = "vpc-1-production-rtb"
    env        = var.env[1]
    scenario = "${var.scenario}"
  }
  depends_on = [var.test_tgw_id]
}
resource "aws_route_table" "vpc-rtb1" {
  count = 1
  vpc_id = "${aws_vpc.vpc[2].id}"

  route {
    cidr_block = var.vpc_rtb_cidr_block 
    transit_gateway_id =  var.test_tgw_id#"${aws_ec2_transit_gateway.test-tgw.id}"
  }
  tags = {
    Name       = "vpc-2-management-rtb"
    env        = var.env[2]
    scenario = "${var.scenario}"
  }
  depends_on = [var.test_tgw_id]
}

resource "aws_route_table" "vpc-rtb2" {
  count = 1
  vpc_id = "${aws_vpc.vpc[0].id}"

  route {
    cidr_block = var.vpc_rtb_cidr_block 
    transit_gateway_id = var.test_tgw_id #"${aws_ec2_transit_gateway.test-tgw.id}"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc-1-igw[count.index].id}"
  }
  tags = {
    Name       = "vpc-0-dev-rtb"
    env        = var.env[count.index]
    scenario = "${var.scenario}"
  }
  depends_on = [var.test_tgw_id]
}


resource "aws_main_route_table_association" "main-rt-vpc" {
  count = 1
  vpc_id         = "${aws_vpc.vpc[1].id}"
  route_table_id = "${aws_route_table.vpc-rtb[count.index].id}"
}

resource "aws_main_route_table_association" "main-rt-vpc1" {
  count = 1
  vpc_id         = "${aws_vpc.vpc[2].id}"
  route_table_id = "${aws_route_table.vpc-rtb1[count.index].id}"
}

resource "aws_main_route_table_association" "main-rt-vpc2" {
  count = 1
  vpc_id         = "${aws_vpc.vpc[count.index].id}"
  route_table_id = "${aws_route_table.vpc-rtb2[count.index].id}"
}