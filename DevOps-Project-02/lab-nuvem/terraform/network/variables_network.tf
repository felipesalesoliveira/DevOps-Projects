################ RESOURCE GROUP #################

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "lab_project_02"
}

################ BASTION #################

variable "bastion_vnet_location" {
  description = "Location of the bastion_vnet"
  type = string
  default = "eastus"
}

variable "bastion_vnet_name" {
  description = "Name of bastion virtual network"
  type = string
  default = "bastion_vnet"
}

variable "bastion_subnet_name" {
  description = "Name of bastion subnet"
  type = string
  default = "bastion_subnet"
}

################ APP #################

variable "app_vnet_location" {
  description = "Location of the app_vnet"
  type = string
  default = "eastus"
}

variable "app_vnet_name" {
  description = "Name of app virtual network"
  type = string
  default = "app_vnet"
}

################ NLB #################

variable "nlb_subnet_name" {
  description = "Name of nlb subnet"
  type = string
  default = "nlb_subnet"
}

################ NLB #################

variable "natgateway_subnet_name" {
  description = "Name of natgateway subnet"
  type = string
  default = "natgateway_subnet"
}