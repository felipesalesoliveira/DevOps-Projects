variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "lab_project_02"
}

variable "bastion_host_location" {
  description = "Location of the bastion host"
  type        = string
  default     = "eastus"
}
