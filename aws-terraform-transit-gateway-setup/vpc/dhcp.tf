resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  count           = 1
  vpc_id          = aws_vpc.vpc[count.index].id
  dhcp_options_id = aws_vpc_dhcp_options.vpc_dhcp_options[count.index].id
}


resource "aws_vpc_dhcp_options" "vpc_dhcp_options" {
  count           = 1
  domain_name         = "service.consul"
  domain_name_servers = ["127.0.0.1", "10.0.0.2"]
  ntp_servers         = ["127.0.0.1"]
  tags                = {
    Environment = "prod"
  }
}
