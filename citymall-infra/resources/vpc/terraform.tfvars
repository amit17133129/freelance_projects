env                                      = "dev"
/* access_key                               = ""
secret_key                               = "" */
region                                   = "us-east-1"
vpc_cidr_block                           = ["10.10.0.0/16"]

private_subnet                           = ["pvt-sub-1", "pvt-sub-2", "pvt-sub-3"]
public_subnet                            = ["pub-sub-1", "pub-sub-2", "pub-sub-3"]

public_subnet_cidr                       = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]

private_subnet_cidr                       = ["10.10.8.0/24", "10.10.7.0/24", "10.10.6.0/24"]
elasticip_name                           = "t4-elasticIP"

az                                       = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnet_map_ip                     = ["true", "true", "true"]

private_subnet_map_ip                    = ["false", "false", "false"]
ig_name                                  = "vpc-igw"

nat_gateway_name                         = "nat_gateway"
bucket_name                              = "vpc-flow-xyz-xyz"

security_group_vpc_name                  = ["sec-group-vpc-1-ssh-icmp"]
image                                    = "ami-0ed9277fb7eb570c9"

key_name                                 = "key000000"
instance_type                            = "t2.micro"