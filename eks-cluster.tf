module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "15.1.0"

  cluster_name    = local.cluster_name
  cluster_version = var.cluster_version
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  tags = {
    Name        = local.cluster_name
    Environment = var.env_tag
  }

  # https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/docs/faq.md#what-is-the-difference-between-node_groups-and-worker_groups
  # https://github.com/terraform-aws-modules/terraform-aws-eks/tree/master/examples/managed_node_groups
  node_groups = {

    managed_node_groups_01 = {
      name             = "node-group-${local.cluster_name}"
      desired_capacity = 2
      max_capacity     = 4
      min_capacity     = 1

      instance_types = ["t2.medium"]
      capacity_type  = "SPOT" # ON_DEMAND|SPOT
      k8s_labels = {
        Environment = "My_K8s_Kabel"
      }
    }

  }

}
