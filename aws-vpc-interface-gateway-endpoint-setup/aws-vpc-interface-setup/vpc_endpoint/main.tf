
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  service_name      = "com.amazonaws.us-east-1.ec2"
  vpc_endpoint_type = "Interface"
  security_group_ids = [
    var.security_group_id,
  ]
  # private_dns_enabled = true
}

resource "aws_vpc_endpoint_subnet_association" "sn_ec2" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  subnet_id       = var.private_subnet_id
}

# associate route table with VPC endpoint
# resource "aws_vpc_endpoint_route_table_association" "Private_route_table_association" {
#   route_table_id  = var.private_route_table_id
#   vpc_endpoint_id = aws_vpc_endpoint.s3.id
# }