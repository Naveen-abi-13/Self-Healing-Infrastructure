output "ec2_public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_instance.self_healing_ec2.public_ip
}
output "eks_cluster_endpoint" {
  description = "EKS cluster API endpoint"
  value       = aws_eks_cluster.self_healing_eks.endpoint
}

output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.self_healing_eks.name
}
