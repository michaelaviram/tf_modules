#general
variable "region" {
  type    = string
  default = "eu-central-1"
}

#eks cluster

variable "cluster_name" {
  type    = string
  default = "Test-Cluster"
}

variable "cluster_version" {
  type    = string
  default = "1.31"
}

variable "instance_type" {
    type = list(string)
    default = ["t3.small"]
}


#tags

variable "environment" {
  type    = string
  default = "dev"
}


#vpc

variable "azs" {
  type    = list(string)
  default = ["eu-central-1a", "eu-central-1b"]
}

variable "vpc_cidr" {
  type        = string
  description = "Vpc cidr"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnets"
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

