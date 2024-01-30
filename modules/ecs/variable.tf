variable "app_name" {}
variable "app_environment" {}
variable "private_subnet_1_id" {}
variable "private_subnet_2_id" {}
variable "vpc_id" {}
variable "cpu" {
    default = "256" # mega-bytes
}
variable "memory" {
    default = "512" # mega-bytes
}
variable "image" {
    default = "tomcat"
}
variable "ecs-containerPort" {
    default = 8080
    type = number
}
variable "desired_count" {
    default = "1"
}
variable "alb-container_port" {
    default = 8080
    type = number
}
variable "container_name" {
    default = "tomcat-container"
}
