resource "azurerm_virtual_network" "app-vnet" {
  name                = var.app_vnet_name
  address_space       = ["172.32.0.0/16"]
  location            = var.app_vnet_location
  resource_group_name = var.resource_group_name
}
