resource "aws_vpc" "vpc_B" {
  cidr_block = var.cidr_block_vpc_B
  tags = {
    Name = "VPC-B"
  }
}


output "vpc_B_id" {
  value = aws_vpc.vpc_B.id
}



