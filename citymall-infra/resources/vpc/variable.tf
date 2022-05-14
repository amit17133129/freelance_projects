variable env {
  type        = string
  description = "environment name"
}
/* variable "access_key" {
}
variable "secret_key" {
} */
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

