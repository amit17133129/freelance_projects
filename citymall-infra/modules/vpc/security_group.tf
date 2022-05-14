resource "aws_security_group" "TerraformSG" {
  name = "${var.env}-security-group"
  vpc_id = "${aws_vpc.vpc[0].id}"
  dynamic "ingress" {
    for_each = var.sg_protocols_ingress
    content {
      from_port = ingress.value["from_port"]
      to_port = ingress.value["to_port"]
      protocol = ingress.value["protocol"]
      cidr_blocks = ["0.0.0.0/0"]
   }
}

 dynamic "egress" {
    for_each = var.sg_protocols_egress
    content {
      from_port = egress.value["from_port"]
      to_port = egress.value["to_port"]
      protocol = egress.value["protocol"]
      cidr_blocks = ["0.0.0.0/0"]
  }
 }
  tags ={
    Environment = "${var.env}-security-group"
  }
}
