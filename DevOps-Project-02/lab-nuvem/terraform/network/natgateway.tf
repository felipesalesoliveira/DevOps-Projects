resource "azurerm_nat_gateway" "natgateway" {
  name                = "nat-gateway"
  location            = var.app_vnet_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "natgateway_subnet" {
  name                 = "natgateway-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.app_vnet_name
  address_prefixes     = ["172.32.1.0/24"]
}

resource "azurerm_subnet_nat_gateway_association" "nat-gateway-subnet-association" {
  subnet_id      = azurerm_subnet.natgateway_subnet.id
  nat_gateway_id = azurerm_nat_gateway.natgateway.id
}