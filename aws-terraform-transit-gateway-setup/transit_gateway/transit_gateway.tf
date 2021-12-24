resource "aws_ec2_transit_gateway" "test-tgw" {
  description                     = "Transit Gateway testing scenario with 4 VPCs, 2 subnets each"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  tags                            = {
    Name                          = "${var.transit_gateway_name}"
    scenario                      = "${var.transit_gateway_name}"
  }
}

output "test_tgw_id" {
  value = aws_ec2_transit_gateway.test-tgw.id
}

