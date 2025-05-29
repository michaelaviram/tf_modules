provider "aws" {
  region = var.region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "project_vpc"
  cidr = var.vpc_cidr

  azs             = var.azs
  private_subnets = var.private_subnet_cidrs
  public_subnets  = var.public_subnet_cidrs

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support = true

 public_subnet_tags = {
     "kubernetes.io/cluster/Test-Cluster" = "shared"
     "kubernetes.io/role/elb" = 1
 }

 private_subnet_tags = {
     "kubernetes.io/cluster/Test-Cluster" = "shared"
     "kubernetes.io/role/internal-elb" = 1
 }

  tags = {
    Terraform   = "true"
    Environment = var.environment
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  
  eks_managed_node_groups = {
    one = {
      instance_types = var.instance_type

      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }
  
  enable_irsa = true

  tags = {
    Environment = var.environment
    Terraform   = "true"
  }
}

resource "null_resource" "k8s_config" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region $REGION --name $CLUSTER"
    environment = {
        REGION = var.region
        CLUSTER = var.cluster_name
    }
  }

  depends_on = [module.eks, module.vpc]
}

