resource "azurerm_virtual_network_peering" "bastion-to-app" {
  name                      = "bastion-to-app"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = var.app_vnet_name
  remote_virtual_network_id = azurerm_virtual_network.app-vnet.id
}
