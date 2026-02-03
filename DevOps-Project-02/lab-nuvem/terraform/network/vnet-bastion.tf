resource "azurerm_virtual_network" "bastion_vnet" {
  name                = var.bastion_vnet_name
  address_space       = ["192.168.0.0/16"]
  location            = var.bastion_vnet_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = var.bastion_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.bastion_vnet_name
  address_prefixes     = ["192.168.1.0/24"]
}