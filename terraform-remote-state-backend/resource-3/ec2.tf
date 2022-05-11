resource "aws_instance" "instance-1" {
  ami                         = var.image
  instance_type               = var.instance_type
  subnet_id                   = data.terraform_remote_state.vpc_subnets_ids.outputs.subnet_ids[0]
  vpc_security_group_ids     = [ data.terraform_remote_state.vpc_security_group_ids.outputs.aws_security_group_name[0] ]
  key_name                    = var.key_name

  tags = {
    Name = "${var.env}-instance-1"
  }
}

resource "aws_instance" "instance-2" {
  ami                         = var.image
  instance_type               = var.instance_type
  subnet_id                   = data.terraform_remote_state.vpc_subnets_ids.outputs.subnet_ids[1]
  vpc_security_group_ids     = [ data.terraform_remote_state.vpc_security_group_ids.outputs.aws_security_group_name[0] ]
  key_name                    = var.key_name

  tags = {
    Name = "${var.env}-instance-2"
  }
}