resource "azurerm_public_ip" "webserver_public_ip" {
  name                = "${var.vm_name}-public_ip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.webserver_public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "webservers" {
  name                  = var.vm_name
  resource_group_name   = var.rg_name
  location              = var.location
  size                  = "Standard_B1s"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.nic.id]

  admin_ssh_key {
    username   = "adminuser"
    public_key = var.admin_ssh_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}