################################################### VPC ##################################################

module  "vpc" {
    source                            = "./vpc" 
    providers = {
        aws = aws.east1
    }
    ig_name                           = var.ig_name 
    cidr_block_vpc_A                  = var.cidr_block_vpc_A
    cidr_block_vpc_B                  = var.cidr_block_vpc_B
    vpc_peer_connection_id            = aws_vpc_peering_connection.peer.id
}

module  "vpc_2" {
    source                            = "./vpc-2" 
    providers = {
        aws = aws.west1
    }
    cidr_block_vpc_A                  = var.cidr_block_vpc_A
    cidr_block_vpc_B                  = var.cidr_block_vpc_B
    vpc_peer_connection_id            = aws_vpc_peering_connection.peer.id
}

##################################################### ec2-instances ##############################################

module "ec2_vpc1" {
    source = "./ec2-vpc1"
    instance_type                            = var.instance_type
    providers = {
        aws = aws.east1
    }
    image_id_vpc_A                           = var.image_id_vpc_A
    key_name_in_east1                        = var.key_name_in_east1
    vpc_A_id                                 = module.vpc.vpc_A_id
    vpc_B_id                                 = module.vpc_2.vpc_B_id
    vpc_A_public_subnet                      = module.vpc.vpc_A_public_subnet
    vpc_A_private_subnet                     = module.vpc.vpc_A_private_subnet
    vpc_B_private_subnet                     = module.vpc_2.vpc_B_private_subnet
}

module "ec2_vpc2" {
    source = "./ec2-vpc2"
    instance_type                            = var.instance_type
    providers = {
        aws = aws.west1
    }
    image_id_vpc_B                           = var.image_id_vpc_B
    key_name_in_west1                        = var.key_name_in_west1
    vpc_A_id                                 = module.vpc.vpc_A_id
    vpc_B_id                                 = module.vpc_2.vpc_B_id
    vpc_A_public_subnet                      = module.vpc.vpc_A_public_subnet
    vpc_A_private_subnet                     = module.vpc.vpc_A_private_subnet
    vpc_B_private_subnet                     = module.vpc_2.vpc_B_private_subnet
}


##################################################### VPN ##############################################

module "vpn" {
    source     = "./vpn"
    vpc_A_id                                 = module.vpc.vpc_A_id
    vpc_B_id                                 = module.vpc_2.vpc_B_id
}
