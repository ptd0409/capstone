output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "bastion_public_ip" {
  value = module.bastion.public_ip
}

output "kubeconfig_command" {
  value = "aws eks --region ${var.aws_region} update-kubeconfig --name ${module.eks.cluster_name}"
}