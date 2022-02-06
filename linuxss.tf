resource "azurerm_linux_virtual_machine_scale_set" "linuxdemo" {
  name                = var.name
  resource_group_name = azurerm_resource_group.project1.name
  location            = azurerm_resource_group.project1.location
  sku                 = "Standard_F2"
  instances           = 1
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
    name    = "nic2"
    primary = true

    ip_configuration {
      name      = "public2"
      primary   = true
      subnet_id = azurerm_subnet.private2.id


    }
  }
}
