#general

variable "region" {
  type    = string
  default = "eu-central-1"
}


#ec2 instance

variable "name" {
  type    = list(string)
  default = ["Prometheus"]
}

variable "ami" {
  type    = string
  default = "ami-0b74f796d330ab49c"
}

variable "type" {
  type    = string
  default = "t2.micro"
}

variable "key" {
  type    = string
  default = "german_key"
}

variable "state" {
  type    = string
  default = "running"
}


#security groups

variable "cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "my_ip" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "port" {
  type    = list(number)
  default = [80, 443]
}

variable "protocol" {
  type    = string
  default = "tcp"
}
