# environment vars
variable "region" {}
variable "project_name" {}
variable "environment" {}


# vpc vars
variable "vpn_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "public_subnet_az2_cidr" {}

variable "private_app_subnet_az1_cidr" {}
variable "private_app_subnet_az2_cidr" {}

variable "private_data_subnet_az1_cidr" {}
variable "private_data_subnet_az2_cidr" {}
