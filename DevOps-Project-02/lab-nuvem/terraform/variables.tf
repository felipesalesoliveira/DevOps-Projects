variable "location" {
  description = "Location of the Azure resources"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "lab_project_02"
}

variable "tags" {
  description = "Tags of the resource group"
  type        = map(string)
  default     = {
    environment = "dev"
    project     = "lab_project_02"
  }
}