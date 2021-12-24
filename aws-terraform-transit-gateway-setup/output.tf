output "vpc_id" {
  value = module.vpc.vpc_id
}
output "tgw_dev_rt_id" {
  value       = module.tw_attachment_vpc1.tgw_dev_rt_id
}

output "vpc_1_2_3_sub_a" {
  value = module.vpc.vpc_1_2_3_sub_a
}
output "vpc_1_2_3_sub_b" {
  value =  module.vpc.vpc_1_2_3_sub_a
}

output "test_tgw_id" {
  value = module.transit_gateway.test_tgw_id
}