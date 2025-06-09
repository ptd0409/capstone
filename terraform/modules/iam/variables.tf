variable "cluster_name" {
  description = "Tên EKS cluster để dùng cho aws_eks_addon"
  type        = string
}

variable "ebs_csi_driver_role_arn" {
  description = "ARN của IAM role dành cho EBS CSI Driver"
  type        = string
}
