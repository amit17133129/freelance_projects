resource "aws_vpc" "vpc" {
  count  = 3 
  cidr_block = var.cidr_block[count.index]
  tags = {
    Name = "vpc-${count.index}-${var.env[count.index]}"
    scenario = "${var.scenario}"
    env = var.env[count.index]
  }
}


output "vpc_id" {
  value = aws_vpc.vpc[*].id
}
