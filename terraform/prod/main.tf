module "vpc" {
  source           = "../modules/vpc"
  name             = var.name
  cidr             = var.vpc_cidr
  azs              = var.azs
  public_subnets   = var.public_subnets
  private_subnets  = var.private_subnets
}

module "iam" {
  source = "../modules/iam"
}

module "ec2" {
  source         = "../modules/ec2"
  vpc_id         = module.vpc.vpc_id
  subnet_id      = module.vpc.public_subnet_ids[0]
  instance_type  = "t3.micro"
  key_name       = var.bastion_key_name
  bastion_name   = "${var.name}-bastion"
}

module "eks" {
  source               = "../modules/eks"
  cluster_name         = var.name
  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.private_subnet_ids
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  eks_node_role_arn    = module.iam.eks_node_role_arn
  node_groups          = var.node_groups
}
