variable env {
  type        = list
}

variable "access_key" {
}
variable "secret_key" {
}
variable "region" {
}
variable scenario {
  type        = string
}

variable cidr_block {
  type        = list
  
}


variable vpc_sub_1 {
  type        = list
}

variable vpc_sub_2 {
  type        = list
  
}
variable vpc_sub_1_cidr {
  type        = list
  
}

variable vpc_sub_2_cidr {
  type        = list
  
}

variable "elasticip_name" {
  type        = string
  
}


variable az {
  type        = list
  
}

variable az1 {
  type        = list
  
}

variable map_public_ip_on_launch {
  type        = list

}

variable map_public_ip_on_launch_1 {
  type        = list

}


variable vpc_rtb_cidr_block {
  type        = string
  
}
# variable "ig" {
#   type        = string
#   "5"
# }



variable vpc_rtb_cidr_block1 {
  type        = string
  
}

variable "transit_gateway_name" {
}

# variable "test_tgw_id" {
#   type        = string
  
# }

variable "ig_name" {
  type        = string
  
}

variable "nat_gateway_name" {
  type        = string
  
}

variable "bucket_name" {
  type        = string
  
}

variable "transit_gateway_vpc_attachment_vpc" {
  type        = list
  
}

variable "security_group_vpc_name" {
  type        = list
  
}


variable "image" {
  type        = string
  
}

variable "key_name" {
  type        = string
  
}

variable "instance_type" {
  type        = string
  
}

