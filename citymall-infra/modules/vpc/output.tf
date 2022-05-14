output "vpc_id" {
  value = aws_vpc.vpc[*].id
}

output "public_subnets" {
  value = aws_subnet.public-subnets[*].id
}

output "private_subnets" {
  value = aws_subnet.private-subnets[*].id
}

output "security_group_id" {
  value = aws_security_group.TerraformSG.id
}