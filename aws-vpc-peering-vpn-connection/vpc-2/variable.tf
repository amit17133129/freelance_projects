variable "az" {
  type        = list
  default     = ["us-west-1a", "us-west-1b", "us-west-1c" ]
  
}



variable "vpc_peer_connection_id" {}
variable "cidr_block_vpc_A" {}
variable "cidr_block_vpc_B" {}