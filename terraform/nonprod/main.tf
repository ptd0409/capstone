module "vpc" {
  source           = "./modules/vpc"
  name             = var.name
  cidr             = var.vpc_cidr
  azs              = var.azs
  private_subnets  = var.private_subnets
  public_subnets   = var.public_subnets
}

module "iam" {
  source = "./modules/iam"
}

module "eks" {
  source               = "./modules/eks"
  cluster_name         = var.name
  vpc_id               = module.vpc.vpc_id
  subnet_ids           = module.vpc.private_subnet_ids
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  eks_node_role_arn    = module.iam.eks_node_role_arn
  node_groups = {
    fe = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1
      instance_types   = ["t3.medium"]
      labels           = { role = "fe" }
    }
    be = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
      labels           = { role = "be" }
    }
    db = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1
      instance_types   = ["t3.large"]
      labels           = { role = "db" }
    }
  }
}

module "bastion" {
  source          = "./modules/ec2"
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.public_subnet_ids[0]
  instance_type   = "t3.micro"
  key_name        = var.bastion_key_name
  bastion_name    = "${var.name}-bastion"
}
