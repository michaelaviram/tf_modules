variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "EKS_Cluster"
}

variable "vpc_id" {
  description = "ID of the VPC where the cluster is created"
  type        = string
  default     = "vpc-06774b48185afd13e"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

