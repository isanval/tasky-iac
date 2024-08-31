# EKS Cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = "wiz-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids         = [aws_subnet.wiz-private-subnet.id, aws_subnet.wiz-private-subnet2.id]
    security_group_ids = [aws_security_group.eks_cluster_sg.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_role_attachment,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller_attachment
  ]

  tags = {
    Name = "eks-cluster"
  }
}

# EKS Node Group
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "my-eks-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.wiz-private-subnet.id, aws_subnet.wiz-private-subnet2.id]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key               = "wiz-ssh-keypair"
    source_security_group_ids = [aws_security_group.eks_node_sg.id]
  }

  tags = {
    Name = "eks-node-group"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_container_registry_read_only
  ]
}
