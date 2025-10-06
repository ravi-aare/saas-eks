variable "region"            { type = string  default = "ap-south-1" }
variable "cluster_name"      { type = string  default = "saas-eks" }
variable "kubernetes_version"{ type = string  default = "1.29" }
variable "vpc_cidr"          { type = string  default = "10.0.0.0/16" }

variable "instance_types"    { type = list(string) default = ["t3.small"] }
variable "min_size"          { type = number default = 1 }
variable "max_size"          { type = number default = 5 }
variable "desired_size"      { type = number default = 2 }
variable "use_spot"          { type = bool   default = true }

variable "app_image"         { type = string default = "111111111111.dkr.ecr.ap-south-1.amazonaws.com/saas-web:latest" }
