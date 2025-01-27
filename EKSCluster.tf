module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.33.1"
  cluster_name = local.cluster_name
  subnet_ids = module.vpc.private_subnets
  enable_irsa = true

tags = {
    cluster_name = "Sahith-EKS_Cluster" 
}

vpc_id = module.vpc.vpc_id

eks_managed_node_group_defaults = {
  instance_types = ["t2.micro"]
  vpc_security_group_ids = [aws_security_group.worker-nodes-mngt.id]
}

eks_managed_node_groups = {
  node_group = {
    min_size = 1
    max_size = 1
    desired_size = 1
  }
}

}

