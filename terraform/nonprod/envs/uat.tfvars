name              = "uat-nonprod"
vpc_cidr          = "10.1.0.0/16"
azs               = ["ap-southeast-1a", "ap-southeast-1b"]
private_subnets   = ["10.1.1.0/24", "10.1.2.0/24"]
public_subnets    = ["10.1.101.0/24", "10.1.102.0/24"]
bastion_key_name  = "my-bastion-key"

node_groups = {
  fe = {
    desired_capacity = 1
    max_capacity     = 2
    min_capacity     = 1
    instance_types   = ["t3.medium"]
    labels           = {
      role = "fe"
      env  = "uat"
    }
  }
  be = {
    desired_capacity = 2
    max_capacity     = 3
    min_capacity     = 1
    instance_types   = ["t3.medium"]
    labels           = {
      role = "be"
      env  = "uat"
    }
  }
  db = {
    desired_capacity = 1
    max_capacity     = 2
    min_capacity     = 1
    instance_types   = ["t3.large"]
    labels           = {
      role = "db"
      env  = "uat"
    }
  }
}
