#Variable for VPC and SUBNET
variable "vpc_name" {}
variable "vpc_cidr" {}
variable "vpc_id" {}
variable "public_subnet_name" {}
variable "private_subnet_name" {}
variable "nat_gateway_name" {}
variable "eip_name" {}
variable "public_route_table_name" {}
variable "private_route_table_name" {}
variable "private_apps_subnet_name" {}
variable "private_apps_route_table_name" {}
variable "endpoint_service_name" {}
variable "endpoint_name" {}
variable "endpoint_type" {}
variable "public_subnet_cidr" {
  type = list(any)
}
variable "private_subnet_cidr" {
  type = list(any)
}
variable "private_apps_subnet_cidr" {
  type = list(any)
}
data "aws_availability_zones" "azs" {}