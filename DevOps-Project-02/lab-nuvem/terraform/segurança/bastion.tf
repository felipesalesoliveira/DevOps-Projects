resource "azurerm_bastion_host" "bastion-host" {
  name                = "bastion-host"
  location            = var.bastion_host_location
  resource_group_name = var.resource_group_name

}