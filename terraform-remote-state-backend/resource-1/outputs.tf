output "vpc_id" {
  value = aws_vpc.vpc[*].id
}

output "aws_security_group_name" {
  value = aws_security_group.sec-group-vpc-ssh-icmp[*].id
}