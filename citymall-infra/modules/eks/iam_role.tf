resource "aws_iam_role" "iam-role-eks-cluster" {
  name = "${var.env}-${var.iam_role_name}"
  assume_role_policy = <<POLICY
{
 "Version": "2012-10-17",
 "Statement": [
   {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
   }
  ]
 }
POLICY
}
