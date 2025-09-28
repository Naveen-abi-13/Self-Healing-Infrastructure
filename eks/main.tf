provider "aws" {
  region = "ap-south-1" # Change to your AWS region
}

resource "aws_iam_role" "eks_role" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_role_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


resource "aws_eks_cluster" "self_healing_eks" {
  name     = "self-healing-eks"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = data.aws_subnets.default.ids
  }
}


data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.self_healing_eks.endpoint
}
