resource "azurerm_network_interface" "demonetwork" {
  name                = "demonetwork-nic"
  location            = azurerm_resource_group.project1.location
  resource_group_name = azurerm_resource_group.project1.name

  ip_configuration {
    name                          = "subnet2"
    subnet_id                     = azurerm_subnet.subnet2.id
    private_ip_address_allocation = "Dynamic"
  }
}