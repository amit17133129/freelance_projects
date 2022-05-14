module "eks" {
    source = "../../modules/eks"
    env                   = var.env
    iam_role_name         = "my-iam-eks-role"
    aws_eks_cluster_name  = "my-eks-cluster"
    node_group_name       = "my-node-group"
    instance_profile_name = "my-eks-instance-profile"
    public_subnet_1_id    = data.terraform_remote_state.vpc_subnets_ids.outputs.public_subnets[0]
    public_subnet_2_id    = data.terraform_remote_state.vpc_subnets_ids.outputs.public_subnets[1]
    security_group_ids    = data.terraform_remote_state.vpc_subnets_ids.outputs.security_group_id
}