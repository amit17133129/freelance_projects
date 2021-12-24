resource "aws_security_group" "sec-group-vpc-ssh-icmp" {
  name        = var.security_group_vpc_name
  description = "test-tgw: Allow SSH and ICMP traffic"
  vpc_id      = var.vpc_id #${resource.aws_vpc.vpc.id}

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
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
    Name = var.security_group_vpc_name
  }
}

output "security_group_id" {
  value = aws_security_group.sec-group-vpc-ssh-icmp.id
}

resource "aws_instance" "private-instance" {
  ami                         = var.image
  instance_type               = var.instance_type
  subnet_id                   = var.private_subnet_id #"${aws_subnet.vpc-sub-1.id}"
  vpc_security_group_ids      = [ "${aws_security_group.sec-group-vpc-ssh-icmp.id}" ]
  key_name                    = var.key_name
  iam_instance_profile        = aws_iam_instance_profile.ec2profile.name
  tags = {
    Name = "${var.private_env}-instance-${var.private_az}"
    # env    = "${var.env[0]}"
    # az          = "${var.az[0]}"
  }
}

resource "aws_instance" "public-instance" {
  ami                         = var.image
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id #"${aws_subnet.vpc-sub-2.id}"
  vpc_security_group_ids      = [ "${aws_security_group.sec-group-vpc-ssh-icmp.id}" ]
  key_name                    = var.key_name
  iam_instance_profile        = aws_iam_instance_profile.ec2profile.name
  tags = {
    Name = "${var.public_env}-instance-${var.public_az}"
    # env    = "${var.env[0]}"
    # az          = "${var.az[0]}"
  }
}