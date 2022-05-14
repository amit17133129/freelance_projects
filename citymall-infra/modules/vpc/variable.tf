variable "env" {
  type        = string
  description = "environment name"
}
variable "region" {
  description = "region name"
}

variable "vpc_cidr_block" {
  description = "cidr block of vpc"
  type        = list
}

variable "public_subnet" {
  description = "public subnet name"
  type        = list
}

variable "private_subnet" {
  description = "private subnet name"
  type        = list
}


variable "public_subnet_cidr" {
  description = "public subnet cidr"
  type        = list
}

variable "private_subnet_cidr" {
  description = "private-subnet-cidr"
  type        = list
}

variable "elasticip_name" {
  type        = string
}

variable "az" {
  description = "avalability zones names"
  type        = list
}

variable "public_subnet_map_ip" {
  description = "specifying subnets to private or public"
  type        = list
}

variable "private_subnet_map_ip" {
  description = "specifying subnets to private or public" 
  type        = list
}


variable "ig_name" {
  description = "internet gateway name"
  type        = string
}

variable "nat_gateway_name" {
  description = "nat gateway name"
  type        = string
}

variable "bucket_name" {
  description = "bucket name"
  type        = string
}

variable "security_group_vpc_name" {
  description = "security group name"
  type        = list
}

variable "image" {
  description = "image name"
  type        = string
}

variable "key_name" {
  description = "key name"
  type        = string
}

variable "instance_type" {
  description = "type of intance"
  type        = string
}

variable "sg_protocols_ingress" {
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
  }))

  default = [
    {
      from_port = 80
      to_port = 80
      protocol = "tcp"
    },
    {
      from_port = 22
      to_port = 22
      protocol = "tcp"
    }
  ]
}

variable "sg_protocols_egress" {
  type = list(object({
    from_port = number
    to_port = number
    protocol = string
  }))

  default = [
    {
      from_port = 0
      to_port = 0
      protocol = "-1"
    }
  ]
}