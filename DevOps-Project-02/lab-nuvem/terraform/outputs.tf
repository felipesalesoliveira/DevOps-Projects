output "load_balancer_subnet_id" {
  value = azurerm_subnet.load_balancer_subnet.id
}

output "nat_gateway_subnet_id" {
  value = azurerm_subnet.nat_gateway_subnet.id
}

output "app_vnet_id" {
  value = azurerm_virtual_network.app_vnet.id
}

output "virtual_network_name" {
  value = azurerm_virtual_network.virtual_network.name
}