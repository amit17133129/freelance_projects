

variable "access_key" {
}
variable "secret_key" {
}
# variable "region" {
# }
# variable az {
#   type        = list
  
# }
# variable "peer_id" {}
variable "cidr_block_vpc_A" {}
variable "cidr_block_vpc_B" {}

variable "ig_name" {
  type        = string
  
}

variable "image_id_vpc_A" {
  type        = string
  
}

variable "image_id_vpc_B" {
  type        = string
  
}

variable "peer_owner_id" {
  
}

variable "key_name_in_east1" {
  type        = string
  
}
variable "key_name_in_west1" {
  type        = string
  
}
variable "instance_type" {
  type        = string
  
}

