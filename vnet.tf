resource "azurerm_virtual_network" "demo_vnet" {
  name                = "demo_vnet"
  location            = azurerm_resource_group.project1.location
  resource_group_name = azurerm_resource_group.project1.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "websubnet" {
  name                 = "websubnet"
  resource_group_name  = azurerm_resource_group.project1.name
  virtual_network_name = azurerm_virtual_network.demo_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "private2" {
  name                 = "private2"
  resource_group_name  = azurerm_resource_group.project1.name
  virtual_network_name = azurerm_virtual_network.demo_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "private3" {
  name                 = "private3"
  resource_group_name  = azurerm_resource_group.project1.name
  virtual_network_name = azurerm_virtual_network.demo_vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

