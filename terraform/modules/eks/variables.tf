variable "cluster_name" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "eks_cluster_role_arn" {}
variable "eks_node_role_arn" {}
variable "node_groups" {
  type = map(object({
    desired_capacity = number
    max_capacity     = number
    min_capacity     = number
    instance_types   = list(string)
    labels           = map(string)
  }))
}

variable "oidc_thumbprint" {
  type        = string
  description = "OIDC thumbprint of Amazon Root CA"
}
