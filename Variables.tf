######### Provider Variables #########

variable "region" {
  description = "Amazon Region"    
  default = "ap-south-1"
}

variable "access_key" {
  default = "AWS_ACCESS_KEY_ID"
}

variable "secret_key" {
  default = "AWS_SECRET_ACCESS_KEY"
}

######### VPC Variables ###########

variable "vpc_cidr" {
    default = "172.16.0.0/16"
}

variable "env" {
    default = "aws"
}
