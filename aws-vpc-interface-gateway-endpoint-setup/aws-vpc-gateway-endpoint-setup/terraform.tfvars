public_env                               = ["public"]
private_env                              = ["private"]
access_key                               = "AKIA3PRKYVGSDLUF32UC"
secret_key                               = "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"
region                                   = "us-east-1"
cidr_block                               = ["10.10.0.0/16"]
public_subnet                            = ["public_subnet"]
private_subnet                           = ["private_subnet"]
public_subnet_cidr                       = ["10.10.1.0/24"]
private_subnet_cidr                      = ["10.10.2.0/24"]
public_az                                = "us-east-1a"
private_az                               = "us-east-1b"
ig_name                                  = "vpc-1-igw"
security_group_vpc_name                  = ["sec-group-vpc-1-ssh-icmp", "sec-group-vpc-1-ssh-icmp1"]
image                                    = "ami-0ed9277fb7eb570c9"
key_name                                 = "eu-east-1-key"
instance_type                            = "t2.micro"




