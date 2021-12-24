################################################### VPC ##################################################

module  "vpc" {
    source                            = "./vpc" 
    public_az                         = var.public_az
    private_az                        = var.private_az
    public_env                        = var.public_env[0]
    private_env                       = var.private_env[0]
    public_subnet                     = var.public_subnet
    private_subnet                    = var.private_subnet
    cidr_block                        = var.cidr_block
    public_subnet_cidr                = var.public_subnet_cidr
    private_subnet_cidr               = var.private_subnet_cidr
    ig_name                           = var.ig_name
}


##################################################### ec2-instamces ##############################################

module "ec2_instances" {
    source = "./ec2"
    security_group_vpc_name                  = var.security_group_vpc_name[0]
    public_az                                = var.public_az
    private_az                               = var.private_az
    public_env                               = var.public_env[0]
    private_env                              = var.private_env[0]
    instance_type                            = var.instance_type
    image                                    = var.image
    key_name                                 = var.key_name
    private_subnet                           = var.private_subnet
    public_subnet                            = var.public_subnet
    vpc_id                                   = module.vpc.vpc_id[0]
    public_subnet_id                         = module.vpc.public_subnet[0]
    private_subnet_id                        = module.vpc.private_subnet[0]
}

##################################################### vpc-gateway-instamces ##############################################

module "vpc_endpoint" {
    source = "./vpc_endpoint"
    vpc_id                                   = module.vpc.vpc_id[0]
    private_route_table_id                   = module.vpc.private_route_table_id 
    security_group_id                        = module.ec2_instances.security_group_id
}