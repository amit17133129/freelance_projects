resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.env}-${var.aws_eks_cluster_name}"
  role_arn =  "${aws_iam_role.iam-role-eks-cluster.arn}"
  version  = "1.19"

  vpc_config {             # Configure EKS with vpc and network settings 
   security_group_ids = [var.security_group_ids]
   subnet_ids         = [var.public_subnet_1_id, var.public_subnet_2_id] # Use Your Subnets here
    }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy,
   ]
}



resource "aws_iam_role" "eks_nodes" {
  name = "${var.env}-${var.node_group_name}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}



resource "aws_iam_instance_profile" "demo-node" {
  name = "${var.env}-${var.instance_profile_name}"
  role = "${aws_iam_role.eks_nodes.name}"
  
#   lifecycle {
#     create_before_destroy = true # or false
#   }
  
}

# Create EKS cluster node group

resource "aws_eks_node_group" "nodes" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.env}-${var.node_group_name}-ng"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = [var.public_subnet_1_id, var.public_subnet_2_id]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}
