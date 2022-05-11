resource "aws_vpc" "vpc" {
  count = 1
  cidr_block = var.vpc_cidr_block[count.index]
  tags = {
    Name = "${var.env}-vpc"
    env = "${var.env}-vpc"
  }
}


resource "aws_security_group" "sec-group-vpc-ssh-icmp" {
  count       = 1
  name        = "${var.env}-${var.security_group_vpc_name}"
  description = "test-tgw: Allow SSH and ICMP traffic"
  vpc_id      = aws_vpc.vpc[count.index].id #${resource.aws_vpc.vpc.id}

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8 # the ICMP type number for 'Echo'
    to_port     = 0 # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0 # the ICMP type number for 'Echo Reply'
    to_port     = 0 # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-${var.security_group_vpc_name}"
  }
}
