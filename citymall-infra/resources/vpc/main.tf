################################################### VPC ##################################################

module  "vpc" {
    source                            = "../../modules/vpc" 
    az                                = var.az
    env                               = var.env
    ig_name                           = var.ig_name
    region                            = var.region 
    key_name                          = var.key_name
    elasticip_name                    = var.elasticip_name
    nat_gateway_name                  = var.nat_gateway_name
    public_subnet                     = var.public_subnet
    private_subnet                    = var.private_subnet
    vpc_cidr_block                    = var.vpc_cidr_block
    private_subnet_cidr               = var.private_subnet_cidr
    public_subnet_cidr                = var.public_subnet_cidr
    public_subnet_map_ip              = var.public_subnet_map_ip
    private_subnet_map_ip             = var.private_subnet_map_ip
    bucket_name                       = var.bucket_name
    security_group_vpc_name           = var.security_group_vpc_name
    image                             = var.image
    instance_type                     = var.instance_type
}


##################################################### ec2-instamces ##############################################

/* module "ec2_instance_vpc1" {
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
} */