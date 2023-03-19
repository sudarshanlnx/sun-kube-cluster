resource "aws_iam_role" "global-node-group-role" {
  name = "node-group-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "global-eks-worker-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.global-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "global-eks-cni-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.global-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "global-eks-container-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.global-node-group-role.name
}


resource "aws_eks_node_group" "global-node-group" {
  cluster_name = aws_eks_cluster.global-cluster.name
  node_group_name = "HighIn"
  node_role_arn = aws_iam_role.global-node-group-role.arn
  subnet_ids = [aws_subnet.pubsub01.id, aws_subnet.pubsub02.id] #aws_subnet.pri01.id, aws_subnet.pri02.id]
  instance_types = ["t2.micro"]
  scaling_config {
    desired_size = 2
    max_size = 2
    min_size = 2
  }
  labels = {
    zone = "west"
  }
  depends_on = [
    aws_iam_role_policy_attachment.global-eks-cni-policy,
    aws_iam_role_policy_attachment.global-eks-container-policy,
    aws_iam_role_policy_attachment.global-eks-worker-policy,
  ]
}
