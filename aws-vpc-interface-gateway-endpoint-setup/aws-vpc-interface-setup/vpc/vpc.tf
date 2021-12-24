resource "aws_vpc" "vpc" {
  count  = 1
  cidr_block = var.cidr_block[count.index]
  tags = {
    Name = "vpc-${count.index}"
  }
  # enable_dns_hostnames = true
}


output "vpc_id" {
  value = aws_vpc.vpc[*].id
}
