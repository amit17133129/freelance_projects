variable "access_key" {
}
variable "secret_key" {
}
variable "region" {
}


variable cidr_block {
  type        = list
  
}


variable public_subnet_cidr {
  type        = list
}

variable private_subnet_cidr {
  type        = list
  
}
variable public_subnet {
  type        = list
  
}

variable private_subnet {
  type        = list
  
}

variable public_env {
  type = list
}
variable private_env {
  type = list
  }

variable public_az {}
variable private_az {}


variable "ig_name" {
  type        = string
  
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

