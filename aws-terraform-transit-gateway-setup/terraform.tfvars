scenario                                 = "test-tgw" 
env                                      = ["dev", "production", "management"]
access_key                               = "AKIAWTVT3K2VHRZOK54L"
secret_key                               = "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"
region                                   = "us-east-1"
cidr_block                               = ["10.10.0.0/16", "10.11.0.0/16", "10.12.0.0/16"]
vpc_sub_1                                = ["vpc-1-sub-a", "vpc-2-sub-a", "vpc-3-sub-a"]
vpc_sub_2                                = ["vpc-1-sub-b", "vpc-2-sub-b", "vpc-3-sub-b"]
vpc_sub_1_cidr                           = ["10.10.1.0/24", "10.11.1.0/24", "10.12.1.0/24"]
vpc_sub_2_cidr                           = ["10.10.2.0/24", "10.11.2.0/24", "10.12.2.0/24"]
elasticip_name                           = "t4-elasticIP"
az                                       = ["us-east-1a", "us-east-1b", "us-east-1c"]
az1                                      = ["us-east-1d", "us-east-1e", "us-east-1f"]
map_public_ip_on_launch                  = ["true", "true", "true"]
map_public_ip_on_launch_1                = ["false", "false", "false"]
vpc_rtb_cidr_block                       = "10.0.0.0/8"
vpc_rtb_cidr_block1                      = "0.0.0.0/0"
transit_gateway_name                     = "test_transit_gateway"
ig_name                                  = "vpc-1-igw"
nat_gateway_name                         = "nat_gateway"
bucket_name                              = "vpc-flow-xyz-xyz"
transit_gateway_vpc_attachment_vpc       = ["tgw-att-vpc1", "tgw-att-vpc2", "tgw-att-vpc3"]
security_group_vpc_name                  = ["sec-group-vpc-1-ssh-icmp", "sec-group-vpc-2-ssh-icmp", "sec-group-vpc-3-ssh-icmp"]
image                                    = "ami-0ed9277fb7eb570c9"
key_name                                 = "key000000"
instance_type                            = "t2.micro"




