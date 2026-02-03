resource "azurerm_bastion_host" "bastion-host" {
  name                = "bastion-host"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

}