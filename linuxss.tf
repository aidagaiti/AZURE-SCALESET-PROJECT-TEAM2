resource "azurerm_resource_group" "project1" {
  name     = "project1-resources"
  location = "West US"
}

resource "azurerm_virtual_network" "demo_vnet" {
  name                = "demo_vnet"
  location            = azurerm_resource_group.project1.location
  resource_group_name = azurerm_resource_group.project1.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.project1.name
  virtual_network_name = azurerm_virtual_network.demo_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_linux_virtual_machine_scale_set" "linux1" {
  name                = "linux1_vmss"
  resource_group_name = azurerm_resource_group.project1.name
  location            = azurerm_resource_group.project1.location
  sku                 = "Standard_F2"
  instances           = 2
  admin_username      = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "azurenetwork"
    primary = true

    ip_configuration {
      name      = "subnet2"
      primary   = true
      subnet_id = azurerm_subnet.subnet2.id
       private_ip_address_allocation = "Dynamic"
    }
  }
}
