variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "Test-Cluster"
}

variable "vpc_id" {
  description = "ID of the VPC where the cluster is created"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

