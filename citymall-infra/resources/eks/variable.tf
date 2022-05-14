variable "iam_role_name" {
  description = "name of the role"
  type = string
}

variable "aws_eks_cluster_name" {
  description = "name of the eks cluster"
  type = string
}

variable "node_group_name" {
  description = "name of the node group"
  type = string
}

variable "instance_profile_name" {
  description = "name of the instance profile"
  type = string
}

variable "env" {
    description = "environment name"
    type = string
}