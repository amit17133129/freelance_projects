
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-att-vpc-prod" {
  subnet_ids         = ["${var.vpc_1_2_3_sub_a}", "${var.vpc_1_2_3_sub_b}"]
  transit_gateway_id = "${var.test_tgw_id}"
  vpc_id             = "${var.vpc_id}"
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  tags               = {
    Name             = var.transit_gateway_vpc_attachment_vpc 
    scenario         = "${var.scenario}"
  }
  depends_on = [var.test_tgw_id]
}






resource "aws_ec2_transit_gateway_route_table" "tgw-prod-rt" {
  transit_gateway_id = var.test_tgw_id#"${var.test_tgw_id.id}"
  tags               = {
    Name             = "tgw-${var.env}-rt"
    scenario         = "${var.scenario}"
  }
  depends_on = [var.test_tgw_id]
}

output "tgw_prod_rt_id" {
  value = aws_ec2_transit_gateway_route_table.tgw-prod-rt.id
}




resource "aws_ec2_transit_gateway_route_table_association" "tgw-rt-vpc-2-assoc-2" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-prod.id}"
  transit_gateway_route_table_id = "${var.tgw_dev_rt_id}" #"${aws_ec2_transit_gateway_route_table.tgw-prod-rt.id}"
}


resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-prod-to-vpc-2" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-prod.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.tgw-prod-rt.id}"
}

resource "aws_ec2_transit_gateway_route_table_propagation" "tgw-rt-prod-vpc-2" {
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-att-vpc-prod.id}"
  transit_gateway_route_table_id = "${var.tgw_dev_rt_id}"# "${aws_ec2_transit_gateway_route_table.tgw-prod-rt.id}"
}
