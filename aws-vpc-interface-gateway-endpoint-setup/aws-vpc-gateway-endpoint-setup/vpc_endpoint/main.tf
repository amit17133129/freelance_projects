
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"
#   security_group_ids = [
#     var.security_group_id,
#   ]
#   private_dns_enabled = false
}
# associate route table with VPC endpoint
resource "aws_vpc_endpoint_route_table_association" "Private_route_table_association" {
  route_table_id  = var.private_route_table_id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}