
output "mongodb-s3-backup-user-id" {
  value = aws_iam_access_key.mongodb-s3-backup-user-key.id
}

output "mongodb-s3-backup-user-key" {
  value = aws_iam_access_key.mongodb-s3-backup-user-key.secret
  sensitive = true
}

output "mongodb-private-ip" {
  value = aws_instance.wiz-mongodb.0.private_ip
}

output "mongodb-public-ip" {
  value = aws_instance.wiz-mongodb.0.public_ip
}

output "cluster_name" {
  value       = aws_eks_cluster.eks_cluster.name
}

output "cluster_arn" {
  value       = aws_eks_cluster.eks_cluster.arn
}

output "load_balancer_dns" {
  value = kubernetes_service.tasky.status[0].load_balancer[0].ingress[0].hostname
}
