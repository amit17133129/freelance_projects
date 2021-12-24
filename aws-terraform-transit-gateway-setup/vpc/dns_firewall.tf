resource "aws_route53_resolver_firewall_rule_group" "route53_fwg" {
  count= 1
  name = "route53_fwg"
}

resource "aws_route53_resolver_firewall_rule_group_association" "route53_fwg_association" {
  count                  = 1
  name                   = "route53_fwg_association"
  firewall_rule_group_id = aws_route53_resolver_firewall_rule_group.route53_fwg[count.index].id
  priority               = 105
  vpc_id                 = aws_vpc.vpc[count.index].id
}