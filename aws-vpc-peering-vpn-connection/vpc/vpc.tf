

resource "aws_vpc" "vpc_A" {

  cidr_block = var.cidr_block_vpc_A
  tags = {
    Name = "VPC-A"
  }
}


output "vpc_A_id" {
  value = aws_vpc.vpc_A.id
}




# resource "aws_vpc_peering_connection" "peer" {
#   peer_owner_id = "789289937316"#var.peer_owner_id
#   peer_vpc_id   = aws_vpc.vpc_A.id
#   vpc_id        = aws_vpc.vpc_B.id
#   auto_accept   = true

#   tags = {
#     Name = "VPC Peering between VPC A and VPC B"
#   }
# }

# resource "aws_vpc_peering_connection_accepter" "peer-accepter" {
#     provider                  = "aws.peer"
#     vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
#     auto_accept               = true
# }