resource "aws_subnet" "public-subnets" {
  count      = 2
  vpc_id     = data.terraform_remote_state.vpc_subnets_ids.outputs.vpc_id[0]
  cidr_block = var.subnet_cidr[count.index]
  availability_zone = "${var.az[count.index]}"
  map_public_ip_on_launch = var.subnet_map_ip[count.index]
  tags = {
    Name = "${var.env}-${var.subnet_name[count.index]}"
    env  = var.env
  }
}