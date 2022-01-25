variable "az" {
  type        = list
  default     = ["us-east-1a", "us-east-1b", "us-east-1c" ]
  
}


variable "ig_name" {}

variable "vpc_peer_connection_id" {}
variable "cidr_block_vpc_A" {}
variable "cidr_block_vpc_B" {}
