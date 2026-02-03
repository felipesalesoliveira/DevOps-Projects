resource "azurerm_application_load_balancer" "load-balancer" {
  name                = var.nlb_subnet_name
  location            = var.app_vnet_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "load-balancer-subnet" {
  name                 = "load-balancer-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.app_vnet_name
  address_prefixes     = ["172.32.2.0/24"]

}

resource "azurerm_application_load_balancer_subnet_association" "load-balancer-subnet-association" {
  name                         = "load-balancer-subnet-association"
  application_load_balancer_id = azurerm_application_load_balancer.load-balancer.id
  subnet_id                    = azurerm_subnet.load-balancer-subnet.id
}