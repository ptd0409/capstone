variable "name" {}
variable "vpc_cidr" {}
variable "azs" {
  type = list(string)
}
variable "private_subnets" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}
variable "bastion_key_name" {}
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
  default     = "9e99a48a9960b14926bb7f3b02e22da0afd40b11"
  description = "Amazon Root CA thumbprint for EKS OIDC"
}
