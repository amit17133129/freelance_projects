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
    scenario = "${var.env}"
  }
}



resource "aws_instance" "private-instance" {
  ami                         = var.image
  instance_type               = var.instance_type
  subnet_id                   = var.vpc_1_2_3_sub_a #"${aws_subnet.vpc-sub-1.id}"
  vpc_security_group_ids     = [ "${aws_security_group.sec-group-vpc-ssh-icmp.id}" ]
  key_name                    = var.key_name

  tags = {
    Name = "${var.env}-instance-${var.az}"
    # env    = "${var.env[0]}"
    # az          = "${var.az[0]}"
  }
}

resource "aws_instance" "public-instance" {
  ami                         = var.image
  instance_type               = var.instance_type
  subnet_id                   = var.vpc_1_2_3_sub_b #"${aws_subnet.vpc-sub-2.id}"
  vpc_security_group_ids     = [ "${aws_security_group.sec-group-vpc-ssh-icmp.id}" ]
  key_name                    = var.key_name

  tags = {
    Name = "${var.env}-instance-${var.az1}"
    # env    = "${var.env[0]}"
    # az          = "${var.az[0]}"
  }
}