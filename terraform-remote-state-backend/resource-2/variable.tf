variable "region" {
  description = "region name"
  type        = string
}

variable "env" {
  description = "environment name"
  type        = string
}
variable "subnet_name" {
  description = "subnet name"
  type        = list
}
variable "subnet_cidr" {
  description = "subnet cidr"
  type        = list
}
variable "subnet_map_ip" {
  description = "specifying subnets to private or public"
  type        = list
}
variable "az" {
  description = "avalability zones names"
  type        = list
}