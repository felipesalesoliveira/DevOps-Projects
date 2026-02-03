resource "azurerm_subnet" "nat-gateway-subnet" {
  name                 = "nat-gateway-subnet"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.app-vnet.name
  address_prefixes     = ["172.32.1.0/24"]
}

resource "azurerm_nat_gateway" "nat-gateway" {
  name                = "nat-gateway"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_subnet_nat_gateway_association" "nat-gateway-subnet-association" {
  subnet_id      = azurerm_subnet.nat-gateway-subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat-gateway.id
}