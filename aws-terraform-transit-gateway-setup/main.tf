################################################### VPC ##################################################

module  "vpc" {
    source                            = "./vpc" 
    az                                = var.az
    az1                               = var.az1
    scenario                          = var.scenario
    elasticip_name                    = var.elasticip_name
    nat_gateway_name                  = var.nat_gateway_name
    vpc_rtb_cidr_block                = var.vpc_rtb_cidr_block
    env                               = var.env
    vpc_sub_1                         = var.vpc_sub_1
    map_public_ip_on_launch           = var.map_public_ip_on_launch
    vpc_sub_2                         = var.vpc_sub_2
    cidr_block                        = var.cidr_block
    vpc_sub_1_cidr                    = var.vpc_sub_1_cidr
    vpc_sub_2_cidr                    = var.vpc_sub_2_cidr
    map_public_ip_on_launch_1         = var.map_public_ip_on_launch_1
    test_tgw_id                       = module.transit_gateway.test_tgw_id 
    ig_name                           = var.ig_name
    bucket_name                       = var.bucket_name
}


############################################## Transit Gateway ##############################################


module "transit_gateway" {
    source = "./transit_gateway"
    env                                      = var.env[1]
    scenario                                 = var.scenario
    vpc_id                                   = module.vpc.vpc_id[1]
    vpc_1_2_3_sub_a                          = module.vpc.vpc_1_2_3_sub_a[1]
    vpc_1_2_3_sub_b                          = module.vpc.vpc_1_2_3_sub_b[1]
    transit_gateway_vpc_attachment_vpc       = var.transit_gateway_vpc_attachment_vpc[1]
    transit_gateway_name                     = var.transit_gateway_name
}




############################################## Transit Gateway Attachment ##############################################

module "tw_attachment_vpc1" {
    source = "./tg_attachment_vpc1"
    env                                      = var.env[0]
    scenario                                 = var.scenario
    vpc_id                                   = module.vpc.vpc_id[0]
    vpc_1_2_3_sub_a                          = module.vpc.vpc_1_2_3_sub_a[0]
    vpc_1_2_3_sub_b                          = module.vpc.vpc_1_2_3_sub_b[0]
    transit_gateway_vpc_attachment_vpc       = var.transit_gateway_vpc_attachment_vpc[0]
    test_tgw_id                              = module.transit_gateway.test_tgw_id
    tgw_prod_rt_id                           = module.tw_attachment_vpc2.tgw_prod_rt_id
}
module "tw_attachment_vpc2" {
    source = "./tg_attachment_vpc2"
    env                                      = var.env[1]
    scenario                                 = var.scenario
    test_tgw_id                              = module.transit_gateway.test_tgw_id
    vpc_id                                   = module.vpc.vpc_id[1]
    vpc_1_2_3_sub_a                          = module.vpc.vpc_1_2_3_sub_a[1]
    vpc_1_2_3_sub_b                          = module.vpc.vpc_1_2_3_sub_b[1]
    transit_gateway_vpc_attachment_vpc       = var.transit_gateway_vpc_attachment_vpc[1]
    tgw_dev_rt_id                            = module.tw_attachment_vpc1.tgw_dev_rt_id
}
module "tw_attachment_vpc3" {
    source = "./tg_attachment_vpc3"
    env                                      = var.env[2]
    scenario                                 = var.scenario
    test_tgw_id                              = module.transit_gateway.test_tgw_id
    vpc_id                                   = module.vpc.vpc_id[2]
    vpc_1_2_3_sub_a                          = module.vpc.vpc_1_2_3_sub_a[2]
    vpc_1_2_3_sub_b                          = module.vpc.vpc_1_2_3_sub_b[2]
    transit_gateway_vpc_attachment_vpc       = var.transit_gateway_vpc_attachment_vpc[2]
    tgw_dev_rt_id                            = module.tw_attachment_vpc1.tgw_dev_rt_id
}

##################################################### ec2-instamces ##############################################

module "ec2_instance_vpc1" {
    source = "./ec2"
    security_group_vpc_name                  = var.security_group_vpc_name[0]
    az                                       = var.az[0]
    az1                                      = var.az1[0]
    env                                      = var.env[0]
    instance_type                            = var.instance_type
    scenario                                 = var.scenario
    image                                    = var.image
    key_name                                 = var.key_name
    vpc_sub_1                                = var.vpc_sub_1
    vpc_sub_2                                = var.vpc_sub_2
    vpc_id                                   = module.vpc.vpc_id[0]
    vpc_1_2_3_sub_a                          = module.vpc.vpc_1_2_3_sub_a[0]
    vpc_1_2_3_sub_b                          = module.vpc.vpc_1_2_3_sub_b[0]
}

module "ec2_instance_vpc2" {
    source = "./ec2"
    security_group_vpc_name                  = var.security_group_vpc_name[1]
    az                                       = var.az[1]
    az1                                      = var.az1[1]
    env                                      = var.env[1]
    instance_type                            = var.instance_type
    scenario                                 = var.scenario
    image                                    = var.image
    key_name                                 = var.key_name
    vpc_sub_1                                = var.vpc_sub_1
    vpc_sub_2                                = var.vpc_sub_2
    vpc_id                                   = module.vpc.vpc_id[1]
    vpc_1_2_3_sub_a                          = module.vpc.vpc_1_2_3_sub_a[1]
    vpc_1_2_3_sub_b                          = module.vpc.vpc_1_2_3_sub_b[1]
}
module "ec2_instance_vpc3" {
    source = "./ec2"
    security_group_vpc_name                  = var.security_group_vpc_name[2]
    az                                       = var.az[2]
    az1                                      = var.az1[2]
    env                                      = var.env[2]
    instance_type                            = var.instance_type
    scenario                                 = var.scenario
    image                                    = var.image
    key_name                                 = var.key_name
    vpc_sub_1                                = var.vpc_sub_1
    vpc_sub_2                                = var.vpc_sub_2
    vpc_id                                   = module.vpc.vpc_id[2]
    vpc_1_2_3_sub_a                          = module.vpc.vpc_1_2_3_sub_a[2]
    vpc_1_2_3_sub_b                          = module.vpc.vpc_1_2_3_sub_b[2]
}