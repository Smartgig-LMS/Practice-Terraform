variable "app_name" {}
variable "vpc_id" {}
variable "app_environment" {}
variable "vpc_name" {}
variable "vpc_cidr" {}
variable "subnet_azs" {}
variable "private_subnet_name" {}
variable "private_subnet_cidr" {}
variable "public_subnet_name" {}
variable "public_subnet_cidr" {}
variable "rt-all-traffic-cidr" {
    default = "0.0.0.0/0"
}
